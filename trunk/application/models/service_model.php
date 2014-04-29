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
		$result = array(array());
		
		$rowIndex = (int) $rowIndex;
		$pageSize = (int) $pageSize;
		
		$resultPackets = $this->db->query('CALL sp_getPacketsBy(?,?)', array($rowIndex, $pageSize));
		
		$indexPacket = -1;
		$indexQuest = -1;
		$indexCondition = -1;
		
		$pId = -1;
		$vId = -1;
		//$cId = -1;
		
		if ($resultPackets->num_rows() > 0) {
			
			foreach($resultPackets->result_array() as $row) {
				
				if($pId != $row['pId']) {
					
					$pId = $row['pId'];
					$indexPacket++;
				
					$result[$indexPacket]['Id'] = $row['pId'];
					$result[$indexPacket]['Title'] = $row['pTitle'];
					$result[$indexPacket]['ImageURL'] = $row['pImageURL'];
					
					$vId = $row['vId'];
					$indexQuest = 0;
					
					$result[$indexPacket]['Quests'][$indexQuest]['Id'] = $row['vId'];
					$result[$indexPacket]['Quests'][$indexQuest]['vQuestName'] = $row['vQuestName'];
					$result[$indexPacket]['Quests'][$indexQuest]['vPacketId'] = $row['vPacketId'];
					$result[$indexPacket]['Quests'][$indexQuest]['vPartnerId'] = $row['vPartnerId'];
					$result[$indexPacket]['Quests'][$indexQuest]['vAnimationId'] = $row['vAnimationId'];
					$result[$indexPacket]['Quests'][$indexQuest]['UnlockPoint'] = $row['vUnlockPoint'];
					$result[$indexPacket]['Quests'][$indexQuest]['vCreateDate'] = $row['vCreateDate'];
					
					$indexCondition = 0;
					
					$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Id'] = $row['cId'];
					$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Type'] = $row['cType'];
					$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Value'] = $row['cValue'];
					$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['cVirtualQuestId'] = $row['cVirtualQuestId'];
					$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['ObjectId'] = $row['cObjectId'];
					
				} else {
				
					if($vId == $row['vId']) {
					
						//
						//Van con condition chua nap
						// Tang indexCondition len 1
						$indexCondition++;
						
						$vId = $row['vId'];
						$pId = $row['pId'];
						
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Id'] = $row['cId'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Type'] = $row['cType'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Value'] = $row['cValue'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['cVirtualQuestId'] = $row['cVirtualQuestId'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['ObjectId'] = $row['cObjectId'];
						
					} else {
						
						// tang indexQuest
						$indexQuest++;
						$vId = $row['vId'];
						$pId = $row['pId'];
						
						// nap quest
						$result[$indexPacket]['Quests'][$indexQuest]['Id'] = $row['vId'];
						$result[$indexPacket]['Quests'][$indexQuest]['vQuestName'] = $row['vQuestName'];
						$result[$indexPacket]['Quests'][$indexQuest]['vPacketId'] = $row['vPacketId'];
						$result[$indexPacket]['Quests'][$indexQuest]['vPartnerId'] = $row['vPartnerId'];
						$result[$indexPacket]['Quests'][$indexQuest]['vAnimationId'] = $row['vAnimationId'];
						$result[$indexPacket]['Quests'][$indexQuest]['UnlockPoint'] = $row['vUnlockPoint'];
						$result[$indexPacket]['Quests'][$indexQuest]['vCreateDate'] = $row['vCreateDate'];
						
						// set lai gia tri moi cho indexCondition
						$indexCondition = 0;
						// nap condition
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Id'] = $row['cId'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Type'] = $row['cType'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['Value'] = $row['cValue'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['cVirtualQuestId'] = $row['cVirtualQuestId'];
						$result[$indexPacket]['Quests'][$indexQuest]['Condition'][$indexCondition]['ObjectId'] = $row['cObjectId'];
						
					}
				}
			}
			
			return $result;
		} else
			return array();
	}
	
	public function getPacketsBy1($rowIndex, $pageSize) {
        $arrPacket;
		
		$rowIndex = (int) $rowIndex;
		$pageSize = (int) $pageSize;
		
		$resultPackets = $this->db->query('SELECT * FROM packet LIMIT ?,?', array($rowIndex, $pageSize));
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
		
		$result = array();
		
		//$facebookId = (int) $facebookId;
		
		$resultPackets = $this->db->query('CALL sp_insertUserFb(?,?,?,?)', array($fullName,$email,$phone,$facebookId));
		
		$index = -1;
		$indexQuest = -1;
		$indexCondition = -1;
		
		$userId = -1;
		$vId = -1;
		$cId = -1;
		
		foreach($resultPackets->result_array() as $row) {
			if ($userId == $row['uUserId']) {
			
				if ($vId != $row['vId']) {
					$vId = $row['vId'];
					$indexQuest++;
					
					$result[0]['quests'][$indexQuest]['id'] = $row['vId'];
					$result[0]['quests'][$indexQuest]['questName'] = $row['vQuestName'];
					$result[0]['quests'][$indexQuest]['packetId'] = $row['vPacketId'];
					$result[0]['quests'][$indexQuest]['partnerId'] = $row['vPartnerId'];
					$result[0]['quests'][$indexQuest]['animationId'] = $row['vAnimationId'];
					$result[0]['quests'][$indexQuest]['unlockPoint'] = $row['vUnlockPoint'];
					$result[0]['quests'][$indexQuest]['createDate'] = $row['vCreateDate'];
					$result[0]['quests'][$indexQuest]['status'] = $row['qStatus'];
					
					$indexCondition = 0;
				
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['id'] = $row['cId'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['type'] = $row['cType'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['value'] = $row['cValue'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['virtualQuestId'] = $row['cVirtualQuestId'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['objectId'] = $row['cObjectId'];
				} else {
					$vId = $row['vId'];
					$indexCondition++;
				
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['id'] = $row['cId'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['type'] = $row['cType'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['value'] = $row['cValue'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['virtualQuestId'] = $row['cVirtualQuestId'];
					$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['objectId'] = $row['cObjectId'];
				}
				
			} else {
				$userId = $row['uUserId'];
				
				$result[0]['code'] = $row['code'];
				$result[0]['message'] = $row['message'];
				$result[0]['userId'] = $row['uUserId'];
				$result[0]['facebookId'] = $row['uFacebookId'];
				$result[0]['points'] = $row['uPoints'];
				$result[0]['currentLv'] = $row['uCurrentLevel'];
				
				$vId = $row['vId'];
				$indexQuest = 0;
				
				$result[0]['quests'][$indexQuest]['id'] = $row['vId'];
				$result[0]['quests'][$indexQuest]['questName'] = $row['vQuestName'];
				$result[0]['quests'][$indexQuest]['packetId'] = $row['vPacketId'];
				$result[0]['quests'][$indexQuest]['partnerId'] = $row['vPartnerId'];
				$result[0]['quests'][$indexQuest]['animationId'] = $row['vAnimationId'];
				$result[0]['quests'][$indexQuest]['unlockPoint'] = $row['vUnlockPoint'];
				$result[0]['quests'][$indexQuest]['createDate'] = $row['vCreateDate'];
				$result[0]['quests'][$indexQuest]['status'] = $row['qStatus'];
				
				$indexCondition = 0;
				
				$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['id'] = $row['cId'];
				$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['type'] = $row['cType'];
				$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['value'] = $row['cValue'];
				$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['virtualQuestId'] = $row['cVirtualQuestId'];
				$result[0]['quests'][$indexQuest]['conditions'][$indexCondition]['objectId'] = $row['cObjectId'];
			}
		}
		
		return $result;
    }
}