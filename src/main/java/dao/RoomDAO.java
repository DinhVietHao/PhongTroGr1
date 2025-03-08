/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import until.DBContext;

/**
 *
 * @author Admin
 */
public class RoomDAO extends DBContext {

    public RoomDAO() {
        super();
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT r.id, r.title, r.description, r.price, r.area, r.address, r.contact_name, r.contact_phone, ri.image_url "
                + "FROM Rooms r "
                + "LEFT JOIN RoomImages ri ON r.id = ri.room_id";

        try {
            PreparedStatement statement = conn.prepareStatement(query);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                Room room = null;
                for (Room r : rooms) {
                    if (r.getId() == id) {
                        room = r;
                        break;
                    }
                }
                if (room == null) {
                    room = new Room();
                    room.setId(id);
                    room.setTitle(rs.getString("title"));
                    room.setDescription(rs.getString("description"));
                    room.setPrice(rs.getDouble("price"));
                    room.setArea(rs.getInt("area"));
                    room.setAddress(rs.getString("address"));
                    room.setContactName(rs.getString("contact_name"));
                    room.setContactPhone(rs.getString("contact_phone"));
                    room.setImages(new ArrayList<String>());
                    rooms.add(room);
                }

                room.getImages().add(rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public static void main(String[] args) {
        RoomDAO rd = new RoomDAO();
        List<Room> list = rd.getAllRooms();
        if (list != null) {
            for (Room room : list) {
                System.out.println(room);
            }
        }
    }

}
