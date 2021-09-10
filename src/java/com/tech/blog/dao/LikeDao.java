package com.tech.blog.dao;

import java.sql.*;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    // with using boolean return type we can find that if it executed properly or not
    public boolean insertLike(int pid, int uid) {
        boolean f = false;
        try {

            String q = "insert into liked(pid, uid) values(?,?);";

            PreparedStatement p = this.con.prepareStatement(q);

            // set values
            p.setInt(1, pid);
            p.setInt(2, uid);

            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // this fuction returns number of likes on a particular post with the hep of given 'pid'
    public int countLikeOnPost(int pid) {
        int count = 0;

        String q = "select count(*) from liked where pid=?;";

        try {
            PreparedStatement p = this.con.prepareStatement(q);

            p.setInt(1, pid);

            ResultSet set = p.executeQuery();

            if (set.next()) {
                count = set.getInt("count(*)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // with this function we can check if a user liked the post or not
    public boolean isLikedByUser(int pid, int uid) {
        boolean f = false;

        try {

            String q = "select * from liked where pid=? AND uid=?;";

            PreparedStatement p = this.con.prepareStatement(q);

            p.setInt(1, pid);
            p.setInt(2, uid);

            ResultSet set = p.executeQuery();

            // if set contains any integer value then that post is already liked by user so it return true.
            if (set.next()) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // with this function we can check if a user has disliked the post or not
    public boolean deleteLike(int pid, int uid) {
        boolean f = false;

        try {

            String q = "delete from liked where pid=? and uid=?;";

            PreparedStatement p = this.con.prepareStatement(q);

            p.setInt(1, pid);
            p.setInt(2, uid);

            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
}
