<?php
										/* Tan - Last 12-March-2014*/
	class Donation_Model extends CI_Model{
		public function __construct(){
			parent:: __construct();
		}
					 /*****SELECT*****/
				/* Last 18-March-2014 */
				
		/*	Get a donation function from databases*/			
		public function getActivity($id, $partner_id){
			$sql = 'CALL sp_Get_Activity(?, ?)';
			$result = $this->db->query($sql, array($id, $partner_id));
			
			return $result->result();//$result->row()->{'Id'} ;//$result->result();
		}
		
		/*	Get Donation list function from databases*/
		public function getDonationList($currentPage, $pageSize) {
			
				$currentPage = (int) $currentPage;
				$pageSize = (int) $pageSize;
				
				$sql = 'CALL sp_Get_DonationList(?, ?)';
				$result = $this->db->query($sql, array($currentPage, $pageSize));
					
				return $result->result();
			
        }
		/*	Donation insert function*/
		public function insertDonation($title, $description, $partner_id){
			
			try{
				$sql = 'CALL sp_Insert_Donation(?, ?, ?)';
				$result = $this->db->query($sql, array($title, $description, $partner_id));
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
		
						/*****UPDATE*****/
					/* Last 17-March-2014 */
		/* Update RequiredPoint function from Donation Table*/
		public function updateRequiredPoint($Id, $BonusPoint){
			try{
				// Call sp_Update_BonusPoint_Quiz StoreProcedure
				$sql = 'Call sp_Update_RequiredPoint_Donation(?, ?)';
				$result = $this->db->query($sql, array($Id, $BonusPoint));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
		
		/* Update IsApproved function from Donation Table*/
					// Last 18-March-2014
		public function updateIsApproved($Id, $IsApproved){
			try{
				// Call sp_Update_DonationApprove StoreProcedure
				$sql = 'Call sp_Update_DonationApprove(?, ?)';
				$result = $this->db->query($sql, array($Id, $IsApproved));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
								/****DELETE****/
							/* Last 12-March-2014 */
		/* Delete Donation function */
		public function deleteDonation($Id){
			try{
				$sql = 'CALL sp_Delete_Donation(?)';
				$result = $this->db->query($sql, array($Id));
				
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
	}	
?>