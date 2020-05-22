package edu.mum.cs.cs472.finalproject.repository;

import edu.mum.cs.cs472.finalproject.dbConnection.HibernateUtil;
import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.model.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import java.util.List;

public class UserDao {

    public boolean saveUser(User user) {
        Transaction transaction = null;
        try (Session registerSession = HibernateUtil.getSessionFactory().openSession()) {
            // start a transaction
            transaction = registerSession.beginTransaction();
            // save the student object
            registerSession.save(user);
            // commit transaction
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return false;
    }

    public User getUser(String userName) {
        User user = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            String hql = "from User U WHERE U.username = :userName";
            Query query = session.createQuery(hql);
            query.setParameter("userName", userName);
            user = (User)  query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserbyId(int userId) {
        User user = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            String hql = "from User U WHERE U.id = :userId";
            Query query = session.createQuery(hql);
            query.setParameter("userId", userId);
            user = (User)  query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }


    public boolean validate(String userName, String password) {

        Transaction transaction = null;
        User user = null;

//        if (HibernateUtil.getSessionFactory().isOpen())
//            HibernateUtil.getSessionFactory().close();

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // start a transaction
            System.out.println("validate 0 =>");
//            Session session2 = HibernateUtil.getSessionFactory().getCurrentSession();
           // transaction = session.beginTransaction();
            // get an user object
            System.out.println("validate 1 =>"+session);
//            user = (User) session.createQuery("FROM User U WHERE U.userName = :userName").setParameter("userName", userName)
//                    .uniqueResult();

            String hql = "from User U WHERE U.username = :userName";
            System.out.println("validate 1.0 =>");
            Query query = session.createQuery(hql);
            System.out.println("validate 1.1 =>");
            query.setParameter("userName", userName);
            System.out.println("validate 1.2=>");
            user = (User)  query.uniqueResult();
            System.out.println("validate 1.3=>");

            System.out.println("validate 2 =>"+user);
            if(user != null && user.getPassword().equals(password)) {
                return true;
            }

            // commit transaction
         //   transaction.commit();

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            System.out.println("validate Exception =>"+e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int userId) {
        Transaction transaction = null;
        User user = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String sql = "select * from User U WHERE U.id = :userId";

            NativeQuery query = session.createSQLQuery(sql);
            query.setParameter("userId", userId);
            query.addEntity(User.class);
            user = (User)  query.uniqueResult();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return user;
    }
}
