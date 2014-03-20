<?php 
						/* Tan - Last 11-March-2014*/
						
	class Quiz_Model extends CI_Model{
		public function __construct(){
			parent::__construct(); 
		}
						/****GET****/
					/* Last 11-March-2014 */
		/*	Get System time*/
		public function getTime(){
			$time = getdate(); 
			$currentDate = $time["year"] . "-" . $time["mon"] . "-" . $time["mday"].' '.$time["hours"] . ":" . $time["minutes"] . ":" . $time["seconds"]; 
			return $currentDate;
		}
					
		/*	Get a quiz function from databases*/			
		public function getQuiz($Id){
			$sql = 'CALL sp_Get_Quiz(?)';
			$result = $this->db->query($sql, array($Id));
			return $result->row();
		}
		
		/*	Get quiz list function from databases*/
		public function getQuizList($currentPage, $pageSize) {
			// try {
				$currentPage = (int) $currentPage;
				$pageSize = (int) $pageSize;
			
				$sql = 'CALL sp_Get_QuizList(?, ?)';
				$query = $this->db->query($sql, array($currentPage, $pageSize));
									
			return $query->result();
        }
    
						/****INSERT****/
					/* Last 11-March-2014 */
		/* Insert a new quiz function into databases			
				Parameter passed:
					questCategory int,
					questQuestion nvarchar(140),
					answerA 	  nvarchar(50),
					answerB       nvarchar(50),
					answerC 	  nvarchar(50),
					answerD       nvarchar(50),
					CorrectChoiceId int,
					sharingInfo	  nvarchar(8000),
					linkURL	      nvarchar(200),
					partnerId	  int,
					createdDate	  datetime */
		
		public function insertQuiz($questCategory, $questQuestion, $CorrectChoiceId,
									$sharingInfo, $linkURL, $partnerId, $createDate){
			
			try{
				$sql = 'CALL sp_Insert_Quiz(?, ?, ?, ?, ?, ?, ?)';
				$result = $this->db->query($sql, array($questCategory, $questQuestion, $CorrectChoiceId,
														$sharingInfo, $linkURL, $partnerId, $createDate));
				
			}catch(Exception $e){
				
				return $e->getMessage();
			}
			return "Success";
		}
		
		/* Insert choice function into Choice table
			 Input parameters: + Content varchar()*/
		public function insertChoice($Content){
			try{
				$sql = 'CALL sp_Insert_Choice(?)';
				$result = $this->db->query($sql, array($Content));
			}catch(Exception $e){
				
			}
		}
		/*	Get Id function of Choice table to filter correct choice */
		public function getChoiceId(){
			
		//	Get quiz Id from Quiz table		
			$sql = 'SELECT MAX(quiz.Id) FROM quiz';
			$result = $this->db->query($sql, array());
			
			$QuestionId = $result->row();
			$Id = $QuestionId->{'MAX(quiz.Id)'} + 1;
		
		//	Get min choice Id from Choice table	
			$sql1 = 'SELECT MIN(choice.Id) FROM travel_hero.choice WHERE choice.QuestionId = ?';
			$result1 = $this->db->query($sql1, array($Id));
			
			$minId = $result1->row()->{'MIN(choice.Id)'}; 
			return (int)$minId;
		}
		
						/****UPDATE****/
					/* Last 11-March-2014 */
					
		/*	Update a quiz function into Quiz table
				Input parameters:
					Id 				int,
					questCategory 	int,
					questQuestion 	nvarchar(140),
					CorrectChoiceId int,
					sharingInfo		nvarchar(8000),
					linkURL	      	nvarchar(200),
					createdDate	  	datetime
				*/
		public function updateQuiz($Id, $questCategory, $questQuestion, $CorrectChoiceId,
													$sharingInfo, $linkURL, $createDate){
			try{							
				$sql = 'CALL sp_Update_Quiz(?, ?, ?, ?, ?, ?, ?)';
				$result = $this->db->query($sql, array($Id, $questCategory, $questQuestion, $CorrectChoiceId,
															$sharingInfo, $linkURL, $createDate));
				return "Success";
			}catch(Exception $e){
				
				return $e->getMessage();
			}
			
		}
		
		/* Get min Id function*/
		public function getMinChoiceId($Id){
			try{
				// Select minChoiceId from Choice Table
				$sql = 'SELECT MIN(choice.Id) FROM travel_hero.choice WHERE choice.QuestionId = ?';
				$result = $this->db->query($sql, array($Id));
	
				// Get minChoiceId
				$minChoiceId = $result->row()->{'MIN(choice.Id)'};
				
			}catch(Exception $e){
				return $e->getMessage();
			}
			return (int)$minChoiceId;
		}
		
		/* Update choice function from Choice Table*/
		public function updateChoice($Id, $Content){
			try{
				// Call sp_Update_Choice StoreProcedure
				$sql = 'CALL sp_Update_Choice(?, ?)';
				$result = $this->db->query($sql, array($Id, $Content));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
		
		/* Update BonusPoint function from Quiz Table*/
		public function updateBonusPoint($Id, $BonusPoint){
			try{
				// Call sp_Update_BonusPoint_Quiz StoreProcedure
				$sql = 'Call sp_Update_BonusPoint_Quiz(?, ?)';
				$result = $this->db->query($sql, array($Id, $BonusPoint));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
		
		/* Update IsApproved function from Quiz Table*/
					// Last 17-March-2014
		public function updateIsApproved($Id, $IsApproved){
			try{
				// Call sp_Update_QuizApprove StoreProcedure
				$sql = 'Call sp_Update_QuizApprove(?, ?)';
				$result = $this->db->query($sql, array($Id, $IsApproved));
				return "Success";
			}catch(Exception $e){
				return $e->getMessage();
			}
			
		}
								/****DELETE****/
							/* Last 12-March-2014 */
		/* Delete quiz and choice function from Quiz Table, Choice Table */
		public function deleteQuiz($Id){
			try{
				$sql = 'CALL sp_Delete_Quiz(?)';
				$result = $this->db->query($sql, array($Id));
				
				return 'Success';
			}catch(Exception $e){
				return $e->getMessage();
			}
		}
	}
?>