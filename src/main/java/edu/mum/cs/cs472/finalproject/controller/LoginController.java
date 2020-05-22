package edu.mum.cs.cs472.finalproject.controller;

import edu.mum.cs.cs472.finalproject.model.TransactionSummary;
import edu.mum.cs.cs472.finalproject.model.User;
import edu.mum.cs.cs472.finalproject.repository.TransactionSummaryDao;
import edu.mum.cs.cs472.finalproject.repository.UserDao;

import java.io.IOException;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HomepageController
 */
@WebServlet(
		description = "LoginController",
		urlPatterns = {"",
				"/login"
		})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	private UserDao loginDao;
	private TransactionSummaryDao transactionSummaryDao;

	public void init() {
		loginDao = new UserDao();
		transactionSummaryDao = new TransactionSummaryDao();
	}
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			authenticate(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void authenticate(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("username =>"+request.getParameter("username"));
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (loginDao.validate(username, password)) {
			User loginUser=loginDao.getUser(username);

			request.setAttribute("userId", loginUser.getId());

			Cookie userCookie = new Cookie("USER_ID", Integer.toString(loginUser.getId()));
			String fullName=loginUser.getFirstName();
			Cookie userCookie2 = new Cookie("FULL_NAME", fullName);
			userCookie.setMaxAge(60*60*24*7); //Store cookie for 7 days
			userCookie2.setMaxAge(60*60*24*7); //Store cookie for 7 days
			response.addCookie(userCookie);
			response.addCookie(userCookie2);

			response.sendRedirect("home");

		}else {
//			throw new Exception("Login not successful..");
			request.setAttribute("error",true);
			request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
		}
	}

}
