<?php

/* Tan - Last 18-March-2014 */

class VirtualQuest_Model extends CI_Model {

    public function __construct() {
        parent:: __construct();
    }

    /*     * ***SELECT**** */
    /* Last 18-March-2014 */
    /* 	Get System time */

    public function getTime() {
        $currentDate = date("Y-m-d H:i:s");
        return $currentDate;
    }

    /* 	Get a VirtualQuest function from databases */

	public function getDataVirtualQuestForMobile($id) {
	
		$result = null;
		
		$id = (int) $id;
		
        $sql = 'CALL sp_getVirtualQuestForMobile(?)';
        $resultPackets = $this->db->query($sql, array($id));
		
		if ($resultPackets->num_rows() > 0) {
			
			$data = $resultPackets->result_array();
			
			$result['quest']['Id'] = $data[0]['vId'];
			$result['quest']['QuestName'] = $data[0]['vQuestName'];
			$result['quest']['PacketId'] = $data[0]['vPacketId'];
			$result['quest']['PartnerId'] = $data[0]['vPartnerId'];
			$result['quest']['AnimationId'] = $data[0]['vAnimationId'];
			$result['quest']['UnlockPoint'] = $data[0]['vUnlockPoint'];
			$result['quest']['CreateDate'] = $data[0]['vCreateDate'];
			$result['quest']['Title'] = $data[0]['kTitle'];
			$result['quest']['ImageURL'] = $data[0]['kImageURL'];
			$result['quest']['pPartnerName'] = $data[0]['pPartnerName'];
			$result['quest']['pOrganizationTypeId'] = $data[0]['pOrganizationTypeId'];
			$result['quest']['pAddress'] = $data[0]['pAddress'];
			$result['quest']['pPhoneNumber'] = $data[0]['pPhoneNumber'];
			$result['quest']['pWebsiteUrl'] = $data[0]['pWebsiteUrl'];
			$result['quest']['pLatitude'] = $data[0]['pLatitude'];
			$result['quest']['pLongtitude'] = $data[0]['pLongtitude'];
			$result['quest']['pDescription'] = $data[0]['pDescription'];
			$result['quest']['pIsApproved'] = $data[0]['pIsApproved'];
			$result['quest']['pLogoUrl'] = $data[0]['pLogoUrl'];
			$result['quest']['pIconUrl'] = $data[0]['pIconUrl'];
			
			$indexCondition = -1;
			
			foreach($data as $row) {
				$indexCondition++;
				$result['quest']['condition'][$indexCondition]['Id'] = $row['cId'];
				$result['quest']['condition'][$indexCondition]['Type'] = $row['cType'];
				$result['quest']['condition'][$indexCondition]['Value'] = $row['cValue'];
				$result['quest']['condition'][$indexCondition]['ObjectId'] = $row['cObjectId'];
				
				if ($row['cType'] == 1) {
					$result['quest']['condition'][$indexCondition]['content']['Id'] = $row['Id'];
					$result['quest']['condition'][$indexCondition]['content']['Title'] = $row['Title'];
					$result['quest']['condition'][$indexCondition]['content']['Description'] = $row['Description'];
					$result['quest']['condition'][$indexCondition]['content']['IsApproved'] = $row['IsApproved'];
					$result['quest']['condition'][$indexCondition]['content']['CreateDate'] = $row['CreateDate'];
					$result['quest']['condition'][$indexCondition]['content']['ActionId'] = $row['aActionId'];
					$result['quest']['condition'][$indexCondition]['content']['BonusPoint'] = $row['aBonusPoint'];
					$result['quest']['condition'][$indexCondition]['content']['ActionContent'] = $row['aActionContent'];
					
				} elseif ($row['cType'] == 2) {
					$result['quest']['condition'][$indexCondition]['content']['Id'] = $row['Id'];
					$result['quest']['condition'][$indexCondition]['content']['Title'] = $row['Title'];
					$result['quest']['condition'][$indexCondition]['content']['Description'] = $row['Description'];
					$result['quest']['condition'][$indexCondition]['content']['IsApproved'] = $row['IsApproved'];
					$result['quest']['condition'][$indexCondition]['content']['CreateDate'] = $row['CreateDate'];
					$result['quest']['condition'][$indexCondition]['content']['RequiredPoint'] = $row['dRequiredPoint'];
					$result['quest']['condition'][$indexCondition]['content']['MedalId'] = $row['dMedalId'];
					$result['quest']['condition'][$indexCondition]['content']['ImageUrl'] = $row['mImageUrl'];
				} else {
					$result['quest']['condition'][$indexCondition]['content']['Id'] = $row['Id'];
					$result['quest']['condition'][$indexCondition]['content']['Title'] = $row['Title'];
					$result['quest']['condition'][$indexCondition]['content']['Description'] = $row['Description'];
					$result['quest']['condition'][$indexCondition]['content']['IsApproved'] = $row['IsApproved'];
					$result['quest']['condition'][$indexCondition]['content']['CreateDate'] = $row['CreateDate'];
					$result['quest']['condition'][$indexCondition]['content']['RequiredPoint'] = $row['dRequiredPoint'];
					$result['quest']['condition'][$indexCondition]['content']['MedalId'] = $row['dMedalId'];
				}
			}
			
			return $result;
		} else 
			return array();
		
	}
	
    public function getVirtualQuest($id) {
        
        $sql = 'CALL sp_Get_VirtualQuest(?)';
        $result = $this->db->query($sql, array($id));
		
        $array = array();

        $array['quest'] = array(
            "Id" => $id,
            "QuestName" => $result->row()->{'QuestName'},
            "PartnerName" => $result->row()->{'PartnerName'},
            "UnlockPoint" => $result->row()->{'UnlockPoint'},
            "CreateDate" => $result->row()->{'CreateDate'},
            "PacketId" => $result->row()->{'PacketId'},
            "PacketName" => $result->row()->{'PacketName'},
            "AnimationId" => $result->row()->{'AnimationId'},
            "ImageURL" => $result->row()->{'ImageURL'}
        );
        $i = 0;
        foreach ($result->result_array() as $row) {
            $array['condition'][$i] = array(
                "Id" => $row['Id'],
                "Type" => $row['Type'],
                "ObjectId" => $row['ObjectId'],
                "Value" => $row['Value']
            );
            $i = $i + 1;
        }

        return $array;
		
    }

    /* 	Get VirtualQuest list function from databases */

    public function getVirtualQuestList($currentPage, $pageSize) {

        $currentPage = (int) $currentPage;
        $pageSize = (int) $pageSize;

        $sql = 'CALL sp_Get_VirtualQuestList(?, ?)';
        $result = $this->db->query($sql, array($currentPage, $pageSize));

        return $result->result();
    }

    /*     * **INSERT*** */
    /* Last 19-March-2014 */

    public function insertQuestCondition($type, $name, $Id) {

        try {
            $sql = 'CALL sp_Insert_ConditionQuest(?, ?, ?)';
            $result = $this->db->query($sql, array($type, $name, $Id));
        } catch (Exception $e) {

            return $e->getMessage();
        }
        return "Success";
    }
    
    public function insertQuestConditionPoint($type, $name, $Id, $point) {

        try {
            $sql = 'INSERT INTO questcondition
				(
					questcondition.Type,
					ObjectId,
					VirtualQuestId,
                                        Value
				)
			VALUES
				(
					?,
					?,
					?,
                                        ?
				);';
            $result = $this->db->query($sql, array($type, $name, $Id, $point));
        } catch (Exception $e) {

            return $e->getMessage();
        }
        return "Success";
    }

    // Insert VirtualQuest function
    public function insertVirtualQuest($partnerId, $packetId, $name, $point, $create_date, $animation, $image) {

        try {
            $this->db->trans_start();
            $sql = 'CALL sp_Insert_VirtualQuest(?, ?, ?, ?, ?, ?, ?)';
            $result = $this->db->query($sql, array($partnerId, $packetId, $name, $point, $create_date, $animation, $image));

            $this->db->trans_complete();

            $sql1 = 'SELECT MAX(virtualquest.Id) FROM virtualquest';
            $result1 = $this->db->query($sql1, array());
            $Id = $result1->row()->{'MAX(virtualquest.Id)'};
        } catch (Exception $e) {

            return $e->getMessage();
        }
        return $Id;
    }

    /*     * **UPDATE*** */
    /* Last 24-March-2014 */
    /* Update virtualquest function */

    public function updateVirtualQuest($Id, $partnerId, $packetId, $name, $point, $animation, $image) {

        try {
            $this->db->trans_start();
            $sql = 'CALL sp_Update_VirtualQuest(?, ?, ?, ?, ?,?,?)';
            $result = $this->db->query($sql, array($Id, $partnerId, $packetId, $name, $point, (int)$animation, $image));

            $this->db->trans_complete();
        } catch (Exception $e) {

            return $e->getMessage();
        }
        return "Success";
    }

    /* Update ConditionQuest function */

    public function updateQuestCondition($name, $Id) {

        try {
            $sql = 'CALL sp_Update_QuestCondition(?, ?)';
            $result = $this->db->query($sql, array($name, $Id));
        } catch (Exception $e) {

            return $e->getMessage();
        }
        return "Success";
    }

    /*     * **DELETE*** */
    /* Last 12-March-2014 */
    /* Delete virtualquest function */

    public function deleteVirtualQuest($Id) {
        try {
            $sql = 'CALL sp_Delete_VirtualQuest(?)';
            $result = $this->db->query($sql, array($Id));

            return 'Success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    /* Delete questcondition function */

    public function deleteQuestCondition($Id) {
        try {
            $sql = 'CALL sp_Delete_QuestCondition(?)';
            $result = $this->db->query($sql, array($Id));

            return 'Success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

}

?>