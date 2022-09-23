package com.tech.blog.dao;

import com.tech.blog.entities.Admin;
import com.tech.blog.entities.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    //method to insert data base:
    public boolean saveUser(User user) {
        boolean f = false;
        try {
            //            user-->database

            String query = "insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();

        }
        return f;
    }

//    method to save category
    public boolean saveCategory(String cat, String catdesc) {
        boolean f = false;
        try {
            //            user-->database

            String query = "insert into categories(name,description) values(?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, cat);
            pstmt.setString(2, catdesc);

            pstmt.executeUpdate();
            
            f = true;
        } catch (Exception e) {
            e.printStackTrace();

        }
        return f;
    }

//    get user by user email and user password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "select * from user where email=? and password=?";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                user = new User();
//                data from db
                String name = set.getString("name");
//                set to user object
                user.setName(name);

                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;

    }

//    get admin by user email and user password
    public Admin getAdminByEmailAndPassword(String email, String password) {
        Admin admin = null;

        try {
            String query = "select * from admin where email=? and password=?";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                admin = new Admin();
//                data from db
                String email1 = set.getString("email");
//                set to user object
                admin.setEmail(email1);

                admin.setPassword(set.getString("password"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;

    }

    public boolean updateUser(User user) {
        boolean f = false;
        try {

            String query = "update user set name=? , email=? , password=? , gender=? ,about=?, profile=? where id=?";
            PreparedStatement p = con.prepareStatement(query);

            p.setString(1, user.getName());
            p.setString(2, user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4, user.getGender());
            p.setString(5, user.getAbout());
            p.setString(6, user.getProfile());
            p.setInt(7, user.getId());

            p.executeUpdate();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public User getUserByUserId(int userId) {
        User user = null;
        try {

            String q = "select * from user where id=?";

            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1, userId);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                user = new User();
//                data from db
                String name = set.getString("name");
//                set to user object
                user.setName(name);

                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<User>();

        try {

            String q = "select * from user";

            PreparedStatement pstmt = this.con.prepareStatement(q);

            ResultSet set = pstmt.executeQuery();
            while (set.next()) {

                String name = set.getString("name");
                int id = set.getInt("id");
                String email = set.getString("email");
                String password = set.getString("password");
                String about = set.getString("about");
                String gender = set.getString("gender");
                Timestamp rdate = set.getTimestamp("rdate");
                String profile = set.getString("profile");

                User user = new User(id, name, email, password, gender, rdate, about);

                list.add(user);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteUserById(int uid) {
        boolean f = false;

        try {
            String q = "delete from user where id=?";
            PreparedStatement pstmt = this.con.prepareStatement(q);

            pstmt.setInt(1, uid);

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
}
