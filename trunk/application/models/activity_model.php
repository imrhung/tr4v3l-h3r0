<?php
										/* Tan - Last 13-March-2014*/
	class Activity_Model extends CI_Model{
		public static $ActivityId = array() ;
		public function __construct(){
			parent:: __construct();
		}
				  /*****SELECT*****/
				/* Last 14-March-2014 */
				
		/*	Get a activity function from databases*/			
		public function getActivity($id, $partner_id){
			$sql = 'CALL sp_Get_Activity(?, ?)';
			$result = $this->db->query($sql, array($id, $partner_id));
			
			return $result->result();
		}
		
		/*	Get Activity list function from databases*/
		public function getActivityList($currentPage, $pageSize) {
			
				$currentPage = (int) $currentPage;
				$pageSize = (int) $pageSize;
				
				$sql = 'CALL sp_Get_ActivityList(?, ?)';
				$result = $this->db->query($sql, array($currentPage, $pageSize));
					
				return $result->result();
			
        }
		
						/*****INSERT*****/
					/* Last 13-March-2014 */
				
		/*	Donation insert function*/
		public function insertActivity($title, $description, $partner_id, 
												$action_id, $action_content){
			
			try{
				$sql = 'CALL sp_Insert_Activity(?, ?, ?, ?, ?)';
				$result = $this->db->query($sql, array($title, $description, $partner_id,
																$action_id, $action_content));
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
						/*****UPDATE*****/
					/* Last 17-March-2014 */
		/* Update BonusPoint function from Activity Table*/
		public function updateBonusPoint($Id, $BonusPoint){
			try{
				// Call sp_Update_BonusPoint_Quiz StoreProcedure
				$sql = 'Call sp_Update_BonusPoint_Activity(?, ?)';
				$result = $this->db->query($sql, array($Id, $BonusPoint));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
		
		/* Update IsApproved function from Activity Table*/
					// Last 18-March-2014
		public function updateIsApproved($Id, $IsApproved){
			try{
				// Call sp_Update_ActivityApprove StoreProcedure
				$sql = 'Call sp_Update_ActivityApprove(?, ?)';
				$result = $this->db->query($sql, array($Id, $IsApproved));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
								/****DELETE****/
							/* Last 12-March-2014 */
		/* Delete Activity function */
		public function deleteActivity($Id){
			try{
				$sql = 'CALL sp_Delete_Activity(?)';
				$result = $this->db->query($sql, array($Id));
				
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
	}		
?>