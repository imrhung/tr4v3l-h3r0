<?php
										/* Tan - Last 18-March-2014*/
	class VirtualQuest_Model extends CI_Model{
		public function __construct(){
			parent:: __construct();
		}
							  /*****SELECT*****/
							/* Last 18-March-2014 */
		/*	Get System time*/
		public function getTime(){
			$time = getdate(); 
			$currentDate = $time["year"] . "-" . $time["mon"] . "-" . $time["mday"].' '.$time["hours"] . ":" . $time["minutes"] . ":" . $time["seconds"]; 
			return $currentDate;
		}
		
		/*	Get a VirtualQuest function from databases*/
		public function getVirtualQuest($id) {
							
				$sql = 'CALL sp_Get_VirtualQuest(?)';
				$result = $this->db->query($sql, array($id));
					
				$array = array();
				
				$array['quest'] = array(
					"Id"=>$id,
					"QuestName"=>$result->row()->{'QuestName'},
					"PartnerName"=>$result->row()->{'PartnerName'},
					"UnlockPoint"=>$result->row()->{'UnlockPoint'},
					"CreateDate"=>$result->row()->{'CreateDate'},
					"PacketId"=>$result->row()->{'PacketId'},
					"PacketName"=>$result->row()->{'PacketName'}
					
				);
				$i = 0;
				foreach($result->result_array() as $row){
					$array['condition'][$i] = array(
						"Id"=>$row['Id'],
						"Type"=>$row['Type'],
						"ObjectId"=>$row['ObjectId'],
						"Value"=>$row['Value']
					);
					$i = $i +1;
				}
				
				return $array;				
			
        }
				
		/*	Get VirtualQuest list function from databases*/
		public function getVirtualQuestList($currentPage, $pageSize) {
			
				$currentPage = (int) $currentPage;
				$pageSize = (int) $pageSize;
				
				$sql = 'CALL sp_Get_VirtualQuestList(?, ?)';
				$result = $this->db->query($sql, array($currentPage, $pageSize));
					
				return $result->result();
			
        }
								/****INSERT****/
							/* Last 19-March-2014 */
		public function insertConditionQuest($type, $name){
			
			try{
				$sql = 'CALL sp_Insert_ConditionQuest(?, ?)';
				$result = $this->db->query($sql, array($type, $name));
				
			}catch(Exception $e){
				
				return $e->getMessage();
			}
			return "Success";
		}
		// Insert VirtualQuest function
		public function insertVirtualQuest($partnerId, $packetId, $name, $point, $create_date){
			
			try{
				$sql = 'CALL sp_Insert_VirtualQuest(?, ?, ?, ?, ?)';
				$result = $this->db->query($sql, array($partnerId, $packetId, $name, $point, $create_date));
				
			}catch(Exception $e){
				
				return $e->getMessage();
			}
			return "Success";
		}
								/****DELETE****/
							/* Last 12-March-2014 */
		/* Delete virtualquest function */
		public function deleteVirtualQuest($Id){
			try{
				$sql = 'CALL sp_Delete_VirtualQuest(?)';
				$result = $this->db->query($sql, array($Id));
				
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
	}
?>