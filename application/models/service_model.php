<?php
// Author: Hau
// Start date: 10-April-2014

class Service_Model extends CI_Model {

	public function __construct() {
        parent:: __construct();
    }
	
	public function getTestById($id) {
        $sql = 'SELECT * FROM testtable WHERE id = ?';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }
	
	public function getPacketsBy($rowIndex, $pageSize) {
		$arrPacket;
		
		$rowIndex = (int) $rowIndex;
		$pageSize = (int) $pageSize;
		
		$resultPackets = $this->db->query('CALL sp_getPacketsBy(?,?)', array(0, 3));
		$i = 0;
		foreach($resultPackets->result_array() as $row) {
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
	
	public function getPacketsBy1($rowIndex, $pageSize) {
        $arrPacket;
		
		$rowIndex = (int) $rowIndex;
		$pageSize = (int) $pageSize;
		
		$resultPackets = $this->db->query('SELECT * FROM packet LIMIT ?,?', array(0, 3));
		$i=0;
		foreach($resultPackets->result_array() as $row) {
			$arrPacket[$i] = $row;
			$tmp = $row['Id'];
			$resultQuets = $this->db->query('SELECT * FROM virtualquest WHERE PacketId = ?', array($tmp));
			$y=0;
			foreach($resultQuets->result_array() as $rowQuest) {
				$arrPacket[$i]['Quests'][$y] = $rowQuest;
				$tmp = $rowQuest['Id'];
				$resultCondition = $this->db->query('SELECT * FROM questcondition WHERE VirtualQuestId = ?', array($tmp));
				$z=0;
				foreach($resultCondition->result_array() as $rowCondition) {
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
	
	public function getLeaderBoardBy($id) {
        $sql = 'CALL sp_getLeaderBoardBy(?)';
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
	
	public function insertUserFb($fullName,$email,$phone,$facebookId) {
        try {
            $sql = 'CALL sp_insertUserFb(?,?,?,?)';
            $result = $this->db->query($sql, array($fullName,$email,$phone,$facebookId));
            return 'Success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
	
}