<?php

/* Tan - Last 18-March-2014 */

class Packet_Model extends CI_Model {

    public function __construct() {
        parent:: __construct();
    }

    /*     * ***SELECT**** */
    /* Last 18-March-2014 */

    /* 	Get Packet list function from databases */

    public function getPacketList($currentPage, $pageSize) {

        $currentPage = (int) $currentPage;
        $pageSize = (int) $pageSize;

        $sql = 'CALL sp_Get_PacketList(?, ?)';
        $result = $this->db->query($sql, array($currentPage, $pageSize));

        return $result->result();
    }
    
    /* 	Get Packet availble (have <3 quests) list function from databases */

    public function getPacketAvailableList($currentPage, $pageSize) {

        $currentPage = (int) $currentPage;
        $pageSize = (int) $pageSize;

        $sql = 'CALL sp_Get_PacketAvailableList(?, ?)';
        $result = $this->db->query($sql, array($currentPage, $pageSize));

        return $result->result();
    }

    /*     * ***INSERT**** */
    /* Last 18-March-2014 */
    /* 	Packet insert function */

    public function insertPacket($title, $imageUrl, $partner_id) {

        try {
            $sql = 'CALL sp_Insert_Packet(?, ?, ?)';
            $result = $this->db->query($sql, array($title, $imageUrl, $partner_id));
            return 'Success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

}

?>	