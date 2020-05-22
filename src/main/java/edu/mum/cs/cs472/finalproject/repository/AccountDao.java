package edu.mum.cs.cs472.finalproject.repository;

import edu.mum.cs.cs472.finalproject.dbConnection.HibernateUtil;
import edu.mum.cs.cs472.finalproject.model.Account;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import java.util.List;


public class AccountDao {

    public boolean saveAccount(Account account) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // start a transaction
            transaction = session.beginTransaction();
            // save the student object
            session.save(account);
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

    public void deduct(int billAmount, Account thisAccount) {
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Transaction transaction = session.beginTransaction();
            double balance = thisAccount.getBalance() - billAmount;
            thisAccount.setBalance(balance);
            session.update(thisAccount);
            transaction.commit();
        } catch (Exception e) {
        }
    }

    public Account getAccount(long accountNumber) {
        Transaction transaction = null;
        Account account = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String sql = "select * from Account U WHERE U.account_number = :accountNumber";

            NativeQuery query = session.createSQLQuery(sql);
            query.setParameter("accountNumber", accountNumber);
            query.addEntity(Account.class);
            account = (Account)  query.uniqueResult();

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return account;
    }

    public List<Account> getAccounts(int userId) {
        Transaction transaction = null;
        List<Account> accounts = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String sql = "select * from Account U WHERE U.user_id = :userId";

            NativeQuery query = session.createSQLQuery(sql);
            query.setParameter("userId", userId);
            query.addEntity(Account.class);
            accounts = (List<Account>)  query.list();

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return accounts;
    }

    public List<Account> getAllAccount() {
        Transaction transaction = null;
        List<Account> accounts = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String sql = "select * from Account";


            NativeQuery query = session.createSQLQuery(sql);
            query.addEntity(Account.class);
            accounts = (List<Account>)  query.list();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return accounts;
    }
}
