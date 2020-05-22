package edu.mum.cs.cs472.finalproject.repository;

import edu.mum.cs.cs472.finalproject.dbConnection.HibernateUtil;
import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.model.FundTransfer;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import javax.persistence.*;
import java.io.Serializable;

public class FundTransferDao {

    public boolean saveFundTransfer(FundTransfer fundTransfer) {
        Transaction transaction = null;
        if(fundTransfer.getFromAccount() == fundTransfer.getToAccount())
            return  false;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            NativeQuery query = session.createSQLQuery("select * from account where account.account_number = :from");
            query.setParameter("from", fundTransfer.getFromAccount());
            query.addEntity(Account.class);
            Account fromAccount = (Account) query.uniqueResult();
            if(fromAccount.getBalance() < fundTransfer.getAmount()) {
                transaction.rollback();
                return false;
            }

            session.createSQLQuery("update account set balance = balance + :amount where account_number = :accountNumber")
                    .setParameter("amount", fundTransfer.getAmount())
                    .setParameter("accountNumber", fundTransfer.getToAccount())
                    .executeUpdate();

            session.createSQLQuery("update account set balance = balance - :amount where account_number = :accountNumber")
                    .setParameter("amount", fundTransfer.getAmount())
                    .setParameter("accountNumber", fundTransfer.getFromAccount())
                    .executeUpdate();

            session.save(fundTransfer);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
}
