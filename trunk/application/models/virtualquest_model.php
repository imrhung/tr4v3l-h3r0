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
					
				return $result->result();
			
        }
		/*	Get VirtualQuest list function from databases*/
		public function getVirtualQuestList($currentPage, $pageSize) {
			
				$currentPage = (int) $currentPage;
				$pageSize = (int) $pageSize;
				
				$sql = 'CALL sp_Get_VirtualQuestList(?, ?)';
				$result = $this->db->query($sql, array($currentPage, $pageSize));
					
				return $result->result();
			
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