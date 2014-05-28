<?php

// Author: Hau
// Start date: 10-April-2014

class Service_Model_2 extends CI_Model {

    public function __construct() {
        parent:: __construct();
    }

    public function getTestById($id) {
        $sql = 'SELECT * FROM testtable WHERE id = ?';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    /*
      public function getPacketsBy($rowIndex, $pageSize) {
      $arrPacket;

      $rowIndex = (int) $rowIndex;
      $pageSize = (int) $pageSize;

      $resultPackets = $this->db->query('CALL sp_getPacketsBy(?,?)', array(0, 3));
      $i = 0;
      foreach ($resultPackets->result_array() as $row) {
      $arrPacket[$i] = $row;
      $row['pId']
      $row['pTitle']
      $row['pImageURL']
      $row['vId']
      $row['vQuestName']
      $row['vPacketId']
      $row['vPartnerId']
      $row['vAnimationId']
      $row['vUnlockPoint']
      $row['vCreateDate']
      $row['cId']
      $row['cType']
      $row['cValue']
      $row['cVirtualQuestId']
      $row['cObjectId']

      $i++;
      }
      return $arrPacket;
      }
     * 
     */

    public function getPacketsBy1($rowIndex, $pageSize) {
        $arrPacket;

        $rowIndex = (int) $rowIndex;
        $pageSize = (int) $pageSize;

        $resultPackets = $this->db->query('SELECT * FROM packet LIMIT ?,?', array(0, 3));
        $i = 0;
        foreach ($resultPackets->result_array() as $row) {
            $arrPacket[$i] = $row;
            $tmp = $row['Id'];
            $resultQuets = $this->db->query('SELECT * FROM virtualquest WHERE PacketId = ?', array($tmp));
            $y = 0;
            foreach ($resultQuets->result_array() as $rowQuest) {
                $arrPacket[$i]['Quests'][$y] = $rowQuest;
                $tmp = $rowQuest['Id'];
                $resultCondition = $this->db->query('SELECT * FROM questcondition WHERE VirtualQuestId = ?', array($tmp));
                $z = 0;
                foreach ($resultCondition->result_array() as $rowCondition) {
                    $arrPacket[$i]['Quests'][$y]['Condition'][$z] = $rowCondition;
                    $z++;
                }
                $y++;
            }
            $i++;
        }

        return $arrPacket;
    }

    public function getQuizzBy($id) {
        $sql = 'CALL sp_getQuizzBy(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    public function getUserProfileBy($id) {
        $sql = 'CALL sp_getUserProfileBy(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    public function getUserAwardsBy($id) {
        $sql = 'CALL sp_getUserAwardsBy(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    public function getActivitiesBy($id) {
        $sql = 'CALL sp_getActivitiesBy(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    public function getUserCurrentQuestBy($id) {
        $sql = 'CALL sp_getUserCurrentQuestBy(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    public function getNumberOfChildrenBy($id) {
        $sql = 'CALL sp_getNumberOfChildrenBy(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    public function insertUserQuest($id) {
        try {
            $sql = 'CALL sp_insertUserQuest(?)';
            $result = $this->db->query($sql, array($id));
            return 'Success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function insertUserFb($fullName, $email, $phone, $facebookId) {
        try {
            $sql = 'CALL sp_insertUserFb(?,?,?,?)';
            $result = $this->db->query($sql, array($fullName, $email, $phone, $facebookId));
            return 'Success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    /*
     * Services of Hung
     */

    public function getLeaderBoard($pageNumber, $pageSize, $fbidString) {
        $sql = 'CALL `sp_Get_Leaderboard`(?, ?, ?);';
        $result = $this->db->query($sql, array((int) $pageNumber, (int) $pageSize, $fbidString));

        return $result->result();
    }
    
    public function getUserMedal($pageNumber, $pageSize, $userId) {
        $sql = 'CALL `sp_Get_UserMedal`(?,?,?);';
        $result = $this->db->query($sql, array((int) $pageNumber, (int) $pageSize, (int) $userId));

        return $result->result();
    }

    public function getVirtualQuestTable($questId) {
        $sql = "SELECT * FROM virtualquest WHERE virtualquest.Id = $questId";
        $result = $this->db->query($sql);

        return $result->row();
    }

    public function getAnimation($animationId) {
        $sql = 'CALL `sp_Get_Animation`(?)';
        $result = $this->db->query($sql, array((int) $animationId));

        return $result->row();
    }

    public function getQuizChoiceList($pageNumber, $pageSize, $quizCate) {
        // Get list of quiz first.
        $sql = 'CALL `sp_Get_QuizList_ByCategory`(?, ?, ?)';
        $result = $this->db->query($sql, array((int) $pageNumber, (int) $pageSize, (int) $quizCate));
        $quizList = $result->result();

        // TODO : how to get exactly $pageSize quiz? :)
        // Init return array:
        $quizChoiceArray = array();

        // Then with each quiz/question, we extract needed data:
        foreach ($quizList as $quiz) {
            //$quizChoice = array();
            $choice = array();

            // Question information
            $quizChoice = array(
                'id' => $quiz->Id,
                'content' => $quiz->Content,
                'image_url' => $quiz->ImageURL,
                'correct_choice_id' => $quiz->CorrectChoiceId,
                'learn_more_url' => $quiz->LearnMoreURL,
                'point' => $quiz->BonusPoint,
                'sharing_info' => $quiz->SharingInfo
            );
            // Make choices list. 
            // And determine "choice_type": long or short
            $maxChoiceLength = 0;
            mysqli_next_result($this->db->conn_id);
            $sql2 = 'CALL sp_Get_Quiz(?)';
            $result2 = $this->db->query($sql2, array((int) $quiz->Id));
            foreach ($result2->result() as $row) {
                $choice[] = array(
                    'id' => $row->Id,
                    'content' => $row->answer
                );
                if (strlen($row->answer) > $maxChoiceLength) {
                    $maxChoiceLength = strlen($row->answer);
                }
            }

            if ($maxChoiceLength > 17) {
                $quizChoice['choice_type'] = 0;
            } else {
                $quizChoice['choice_type'] = 1;
            }
            $quizChoice['choice'] = $choice;

            // Add to quiz list:
            $quizChoiceArray[] = $quizChoice;
        }
        return $quizChoiceArray;
    }

    /*
     * Return integer value of Quiz category
     */

    public function getQuizCategoryInQuest($questId) {
        mysqli_next_result($this->db->conn_id);
        $sql = "SELECT questcondition.ObjectId FROM questcondition WHERE VirtualQuestId = $questId AND Type = 0";
        $result = $this->db->query($sql);

        return (int) $result->row()->ObjectId;
    }

    /*
     * End of Hung's services
     */
}
