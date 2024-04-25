package uz.muhammadtrying.iticketproject.servlet;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import uz.muhammadtrying.iticketproject.entity.Purchase;
import uz.muhammadtrying.iticketproject.entity.Seat;
import uz.muhammadtrying.iticketproject.entity.User;
import uz.muhammadtrying.iticketproject.entity.enums.Status;
import uz.muhammadtrying.iticketproject.repo.PurchaseRepo;
import uz.muhammadtrying.iticketproject.repo.SeatRepo;
import uz.muhammadtrying.iticketproject.repo.SessionRepo;
import uz.muhammadtrying.iticketproject.repo.UserRepo;

import java.time.format.DateTimeFormatter;
import java.util.Optional;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

@WebServlet(value = "/auth-servlet")
public class AuthServlet extends HttpServlet {
    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        if (req.getParameter("function") != null && req.getParameter("function").equals("emailSending")) {
            String email = req.getParameter("email");
            UUID seatId = UUID.fromString(req.getParameter("seatId"));
            UUID chosenSessionId = UUID.fromString(req.getParameter("chosenSessionId"));
            req.getSession().setAttribute("seatId", seatId);
            req.getSession().setAttribute("chosenSessionId", chosenSessionId);
            String code = sendEmail(email);
            req.setAttribute("code", code);
            req.getRequestDispatcher("/confirm-purchase.jsp").forward(req, resp);
        } else if (req.getParameter("function") != null && req.getParameter("function").equals("verify")) {
            String enteredCode = req.getParameter("enteredCode");
            String realCode = req.getParameter("realCode");
            UUID chosenSessionId = (UUID) req.getSession().getAttribute("chosenSessionId");
            if (enteredCode.equals(realCode)) {
                makeAPurchase(req);
                req.setAttribute("purchase", "success");
            } else {
                req.setAttribute("purchase", "fail");
            }
            req.setAttribute("chosenSessionId", chosenSessionId);
            req.getRequestDispatcher("/confirmedPurchase.jsp").forward(req, resp);
        } else {
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            Optional<User> optionalUser = UserRepo.findByName(username);
            if (optionalUser.isPresent()) {
                User user = optionalUser.get();
                if (user.getPassword().equals(password)) {
                    req.getSession().setAttribute("currentUser", user);
                    resp.sendRedirect("/homepage.jsp");
                    return;
                }
            }
            resp.sendRedirect("/");
        }
    }

    private String sendEmail(String recipientEmail) throws MessagingException {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("muhammadtrying@gmail.com",
                        "eajkgnvbwwcfwvuu");
            }
        });
        Random random = new Random();
        String text = String.valueOf(random.nextInt(9000) + 1000);
        Message message = new MimeMessage(session);
        message.setSubject("VERIFICATION EMAIL");
        message.setText("Your code is: " + text + ". Don't share it to anyone!");
        message.setFrom(new InternetAddress("muhammadtrying@gmail.com"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
        Transport.send(message);
        return text;
    }

    private void makeAPurchase(HttpServletRequest req) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d hh:mm a");
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        SeatRepo seatRepo = new SeatRepo();
        SessionRepo sessionRepo = new SessionRepo();
        UUID seatId = (UUID) req.getSession().getAttribute("seatId");
        UUID chosenSessionId = (UUID) req.getSession().getAttribute("chosenSessionId");
        Seat chosenSeat = seatRepo.findById(seatId);
        uz.muhammadtrying.iticketproject.entity.Session chosenSession = sessionRepo.findById(chosenSessionId);
        seatRepo.begin();
        chosenSeat.setStatus(Status.TAKEN);
        seatRepo.commit();

        Purchase purchase = Purchase.builder()
                .hall(chosenSession.getHall().getName())
                .user(currentUser)
                .movie(chosenSession.getMovie().getName())
                .sessionTime(chosenSession.getTime().format(formatter))
                .price(200)
                .build();
        PurchaseRepo purchaseRepo = new PurchaseRepo();
        purchaseRepo.save(purchase);
    }
}
