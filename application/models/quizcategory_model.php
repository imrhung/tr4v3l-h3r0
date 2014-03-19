<?php
										/* Tan - Last 18-March-2014*/
	class QuizCategory_Model extends CI_Model{
		public function __construct(){
			parent:: __construct();
		}
							  /*****SELECT*****/
							/* Last 18-March-2014 */
				
		/*	Get QuizCategory list function from databases*/
		public function getQuizCategoryList($currentPage, $pageSize) {
			
				$currentPage = (int) $currentPage;
				$pageSize = (int) $pageSize;
				
				$sql = 'CALL sp_Get_QuizCategoryList(?, ?)';
				$result = $this->db->query($sql, array($currentPage, $pageSize));
					
				return $result->result();
			
        }
		
							/*****INSERT*****/
							/* Last 18-March-2014 */
		/*	Packet insert function*/
		public function insertQuizCategory($category){
			
			try{
				$sql = 'CALL sp_Insert_QuizCategory(?)';
				$result = $this->db->query($sql, array($category));
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
	}
?>	