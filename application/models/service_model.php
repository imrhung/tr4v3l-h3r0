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
		
		foreach($resultPackets->result_array() as $row) {
			
			if($pId != $row['pId']) {
				
				$pId = $row['pId'];
				$indexPacket++;
			
				$result[$indexPacket]['pId'] = $row['pId'];
				$result[$indexPacket]['pTitle'] = $row['pTitle'];
				$result[$indexPacket]['pImageURL'] = $row['pImageURL'];
				
				$vId = $row['vId'];
				$indexQuest = 0;
				
				$result[$indexPacket]['Quest'][$indexQuest]['vId'] = $row['vId'];
				$result[$indexPacket]['Quest'][$indexQuest]['vQuestName'] = $row['vQuestName'];
				$result[$indexPacket]['Quest'][$indexQuest]['vPacketId'] = $row['vPacketId'];
				$result[$indexPacket]['Quest'][$indexQuest]['vPartnerId'] = $row['vPartnerId'];
				$result[$indexPacket]['Quest'][$indexQuest]['vAnimationId'] = $row['vAnimationId'];
				$result[$indexPacket]['Quest'][$indexQuest]['vUnlockPoint'] = $row['vUnlockPoint'];
				$result[$indexPacket]['Quest'][$indexQuest]['vCreateDate'] = $row['vCreateDate'];
				
				$indexCondition = 0;
				
				$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cId'] = $row['cId'];
				$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cType'] = $row['cType'];
				$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cValue'] = $row['cValue'];
				$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cVirtualQuestId'] = $row['cVirtualQuestId'];
				$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cObjectId'] = $row['cObjectId'];
				
			} else {
			
				if($vId == $row['vId']) {
				
					//
					//Van con condition chua nap
					// Tang indexCondition len 1
					$indexCondition++;
					
					$vId = $row['vId'];
					$pId = $row['pId'];
					
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cId'] = $row['cId'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cType'] = $row['cType'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cValue'] = $row['cValue'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cVirtualQuestId'] = $row['cVirtualQuestId'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cObjectId'] = $row['cObjectId'];
					
				} else {
					
					// tang indexQuest
					$indexQuest++;
					$vId = $row['vId'];
					$pId = $row['pId'];
					
					// nap quest
					$result[$indexPacket]['Quest'][$indexQuest]['vId'] = $row['vId'];
					$result[$indexPacket]['Quest'][$indexQuest]['vQuestName'] = $row['vQuestName'];
					$result[$indexPacket]['Quest'][$indexQuest]['vPacketId'] = $row['vPacketId'];
					$result[$indexPacket]['Quest'][$indexQuest]['vPartnerId'] = $row['vPartnerId'];
					$result[$indexPacket]['Quest'][$indexQuest]['vAnimationId'] = $row['vAnimationId'];
					$result[$indexPacket]['Quest'][$indexQuest]['vUnlockPoint'] = $row['vUnlockPoint'];
					$result[$indexPacket]['Quest'][$indexQuest]['vCreateDate'] = $row['vCreateDate'];
					
					// set lai gia tri moi cho indexCondition
					$indexCondition = 0;
					// nap condition
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cId'] = $row['cId'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cType'] = $row['cType'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cValue'] = $row['cValue'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cVirtualQuestId'] = $row['cVirtualQuestId'];
					$result[$indexPacket]['Quest'][$indexQuest]['Condition'][$indexCondition]['cObjectId'] = $row['cObjectId'];
					
				}
			}
		}
		
		return $result;
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
        try {
			$facebookId = (int) $facebookId;
            $sql = 'CALL sp_insertUserFb(?,?,?,?)';
            $result = $this->db->query($sql, array($fullName,$email,$phone,$facebookId));
            return $result->row();
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
	
}