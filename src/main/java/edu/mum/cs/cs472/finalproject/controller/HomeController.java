package edu.mum.cs.cs472.finalproject.controller;

import edu.mum.cs.cs472.finalproject.model.Account;
import edu.mum.cs.cs472.finalproject.model.TransactionSummary;
import edu.mum.cs.cs472.finalproject.model.User;
import edu.mum.cs.cs472.finalproject.repository.AccountDao;
import edu.mum.cs.cs472.finalproject.repository.TransactionSummaryDao;
import edu.mum.cs.cs472.finalproject.repository.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet(
        description = "LoginController",
        urlPatterns = {
                "/home"
        })
public class HomeController extends HttpServlet {

    private TransactionSummaryDao transactionSummaryDao;
    private UserDao loginDao;
    private AccountDao accountDao;
    public void init() {
        loginDao = new UserDao();
        transactionSummaryDao = new TransactionSummaryDao();
        accountDao=new AccountDao();
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int userId = (int)request.getAttribute("userId");
        System.out.println("userIdAttribute userId ========>"+userId);
//        int userId =Integer.parseInt(userIdAttribute);
//        int userId =1;
        int [] debitData= new int[12];
        int [] creditData=  new int[12];

        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        cal.clear();
        cal.set(Calendar.YEAR, year);
        int totalDebit=0;
        int billPaymentTotal = 0,fundTransferTotal = 0,otherSpendingTotal =0;
        
        for (int currentMonth = 0; currentMonth < 12; currentMonth++) {

            cal.set(Calendar.MONTH, currentMonth);

            //first day :
            cal.set(Calendar.DAY_OF_MONTH, 1);
            Date firstDay = cal.getTime();

            //last day
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            Date lastDay = cal.getTime();
            int totalCurrentMonthDebit=0;int totalCurrentMonthCredit=0;
            List<TransactionSummary> transactionHistoryCredit= transactionSummaryDao.getTransactionSummary(firstDay,lastDay,userId,"Credit");
            for (TransactionSummary history :transactionHistoryCredit) {

                if(history.getTransactionType().equalsIgnoreCase("bill payment")){
                    billPaymentTotal   +=history.getAmount();
                }else if(history.getTransactionType().equalsIgnoreCase("transfer")){
                    fundTransferTotal +=history.getAmount();
                }else{
                    otherSpendingTotal+=history.getAmount();
                }

                totalCurrentMonthCredit+=history.getAmount();
            }

            List<TransactionSummary> transactionHistory= transactionSummaryDao.getTransactionSummary(firstDay,lastDay,userId,"Debit");
            for (TransactionSummary history :transactionHistory) {
                totalCurrentMonthDebit+=history.getAmount();
                totalDebit+=history.getAmount();

            }
            debitData[currentMonth]=totalCurrentMonthDebit;
            creditData[currentMonth]=totalCurrentMonthCredit;
        }

        request.setAttribute("debitData", debitData);
        request.setAttribute("creditData", creditData);

        List<Account> accounts =accountDao.getAccounts(userId);
        int totalDebitAmount=0;
        for (Account account :accounts) {
            totalDebitAmount+=account.getBalance();
        }
        System.out.println("totalDebitAmount =>"+totalDebitAmount);
        System.out.println("totalDebit =>"+totalDebit);
        totalDebitAmount+=totalDebit;
        System.out.println("totalDebitAmount =>"+totalDebitAmount);
        System.out.println("billPaymentTotal =>"+billPaymentTotal);
        System.out.println("fundTransferTotal =>"+fundTransferTotal);
        System.out.println("otherSpendingTotal =>"+otherSpendingTotal);

        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        int totalSpendings=billPaymentTotal+fundTransferTotal+otherSpendingTotal;
        float billPaymentPerc = (billPaymentTotal * 100.0f) / totalSpendings;
        if (Float.isNaN(billPaymentPerc)){
            System.out.println("billPaymentPerc NaN=>");
            billPaymentPerc=1;
        }else{
            billPaymentPerc+=1;
        }
        System.out.println("billPaymentPerc =>"+billPaymentPerc);
        billPaymentPerc = Float.valueOf(decimalFormat.format(billPaymentPerc));

        float fundTransferPerc = (fundTransferTotal* 100.0f) / totalSpendings;
        if (Float.isNaN(fundTransferPerc)){fundTransferPerc=1;}else{fundTransferPerc+=1;}
        fundTransferPerc = Float.valueOf(decimalFormat.format(fundTransferPerc));

        float otherSpendingPerc = (otherSpendingTotal * 100.0f) / totalSpendings;
        if (Float.isNaN(otherSpendingPerc)){otherSpendingPerc=1;}else{otherSpendingPerc+=1;}
        otherSpendingPerc = Float.valueOf(decimalFormat.format(otherSpendingPerc));

        float [] pieChartData= {fundTransferPerc-1, billPaymentPerc-1 ,otherSpendingPerc-1};

        System.out.println("pieChartData =>"+pieChartData.toString());
        request.setAttribute("pieChartData",pieChartData);
        request.setAttribute("accounts",accounts);
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
