<?php

/* Tan - Last 12-March-2014 */

class Partner_Model extends CI_Model {

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

    /* 	Get a partner function from databases */

    public function getPartner($id) {
        $sql = 'CALL sp_Get_Partner(?)';
        $result = $this->db->query($sql, array($id));

        return $result->row();
    }

    /* 	Get partner list function from databases */

    public function getPartnerList($currentPage, $pageSize) {

        $currentPage = (int) $currentPage;
        $pageSize = (int) $pageSize;

        $sql = 'CALL sp_Get_PartnerList(?, ?)';
        $result = $this->db->query($sql, array($currentPage, $pageSize));

        return $result->result();
    }

    /* Update IsApproved function from Partner Table */

    // Last 18-March-2014
    public function updateIsApproved($Id, $IsApproved) {
        try {
            // Call sp_Update_Partner_IsApproved StoreProcedure
            $sql = 'Call sp_Update_Partner_IsApproved(?, ?)';
            $result = $this->db->query($sql, array($Id, $IsApproved));
            return "Success";
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
}