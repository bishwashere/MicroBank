package edu.mum.cs.cs472.finalproject.repository;

import edu.mum.cs.cs472.finalproject.dbConnection.HibernateUtil;
import edu.mum.cs.cs472.finalproject.model.TransactionSummary;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class TransactionSummaryDao {

    public void saveTransaction(TransactionSummary transactionSummary) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // start a transaction
            transaction = session.beginTransaction();
            // save the student object
            session.save(transactionSummary);
            // commit transaction
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<TransactionSummary> getTransactions(int userId, long accountNumber, int pageIndex, int countPerPage) {
        List<TransactionSummary> transactionSummaries = Arrays.asList();

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            NativeQuery query;
            if(accountNumber == 0) {
                query = session.createSQLQuery(
                        "select * from transaction_summary where user_id=:userId order by transaction_date desc limit :limit offset :offset");
                query.setParameter("userId", userId);
            } else {
                query = session.createSQLQuery(
                        "select * from transaction_summary where user_id=:userId and (from_account=:accountNumber or to_account=:accountNumber)  order by transaction_date desc limit :limit offset :offset");
                query.setParameter("userId", userId);
                query.setParameter("accountNumber", accountNumber);
            }
            query.setParameter("offset", (pageIndex-1)*countPerPage);
            query.setParameter("limit", countPerPage);

            query.addEntity(TransactionSummary.class);
            transactionSummaries = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactionSummaries;
    }

    public long getTransactionsCount(int userId, long accountNumber) {
        long count = 0;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            NativeQuery query;
            if(accountNumber == 0) {
                query = session.createSQLQuery("select count(*) from transaction_summary where user_id=:userId");
                query.setParameter("userId", userId);
            } else {
                query = session.createSQLQuery(
                        "select count(*) from transaction_summary where user_id=:userId and (from_account=:accountNumber or to_account=:accountNumber)");
                query.setParameter("userId", userId);
                query.setParameter("accountNumber", accountNumber);
            }
            count = ((BigInteger)query.getSingleResult()).longValue();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public List<TransactionSummary> getTransactionSummary(Date firstDay, Date lastDay, int userId, String transDesc) {
        Transaction transaction = null;
        List<TransactionSummary> transactionHistory = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String sql = "select * from transaction_summary ts WHERE ts.transaction_date BETWEEN  :firstDay AND :lastDay AND ts.user_id = :userId AND ts.transaction_desc  = :transDesc";
            NativeQuery query = session.createSQLQuery(sql);
            query.setParameter("firstDay", firstDay);
            query.setParameter("lastDay", lastDay);
            query.setParameter("userId", userId);
            query.setParameter("transDesc", transDesc);
            query.addEntity(TransactionSummary.class);
            //System.out.println("query =>"+query.toString());
            transactionHistory =  query.list();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        System.out.println("transactionHistory type =>"+transDesc +" size "+transactionHistory.size());
        return transactionHistory;
    }
}
