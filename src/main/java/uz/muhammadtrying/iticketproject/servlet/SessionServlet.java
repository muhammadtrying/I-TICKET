package uz.muhammadtrying.iticketproject.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.Hall;
import uz.muhammadtrying.iticketproject.entity.Movie;
import uz.muhammadtrying.iticketproject.entity.Seat;
import uz.muhammadtrying.iticketproject.entity.Session;
import uz.muhammadtrying.iticketproject.entity.enums.Status;
import uz.muhammadtrying.iticketproject.repo.HallRepo;
import uz.muhammadtrying.iticketproject.repo.MovieRepo;
import uz.muhammadtrying.iticketproject.repo.SessionRepo;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

import static uz.muhammadtrying.iticketproject.config.DataLoader.emf;

@WebServlet(value = "/session-servlet")
public class SessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        MovieRepo movieRepo = new MovieRepo();
        HallRepo hallRepo = new HallRepo();
        SessionRepo sessionRepo = new SessionRepo();

        if (req.getParameter("function") != null) {
            UUID movieId = UUID.fromString(req.getParameter("movie"));
            UUID hallId = UUID.fromString(req.getParameter("hall"));
            LocalDateTime time = LocalDateTime.parse(req.getParameter("time"));
            UUID sessionId = UUID.fromString(req.getParameter("id"));
            if (isSuchSessionPresent(time, hallId, movieId)) {
                resp.sendRedirect("/sessionUpdate.jsp?id=" + sessionId);
                return;
            }
            Session chosenSession = sessionRepo.findById(sessionId);
            sessionRepo.begin();
            chosenSession.setMovie(movieRepo.findById(movieId));
            chosenSession.setHall(hallRepo.findById(hallId));
            chosenSession.setTime(time);
            sessionRepo.commit();
        } else {
            UUID movieId = UUID.fromString(req.getParameter("movie"));
            UUID hallId = UUID.fromString(req.getParameter("hall"));
            LocalDateTime time = LocalDateTime.parse(req.getParameter("time"));
            Movie movie = movieRepo.findById(movieId);
            Hall hall = hallRepo.findById(hallId);
            if (isSuchSessionPresent(time, hallId, movieId)) {
                resp.sendRedirect("/sessionCreate.jsp");
                return;
            }
            Session session = Session.builder()
                    .movie(movie)
                    .hall(hall)
                    .time(time)
                    .build();
            sessionRepo.save(session);
            generateSeatForThisSession(sessionRepo.em,session);
        }
        resp.sendRedirect("/sessionCrud.jsp");
    }

    private void generateSeatForThisSession(EntityManager entityManager, Session session) {
        for (int i = 1; i <= 12; i++) {
            Seat seat1 = Seat.builder().seatNumber(String.valueOf(i)).status(Status.FREE).session(session).build();
            entityManager.getTransaction().begin();
            entityManager.persist(seat1);
            entityManager.getTransaction().commit();
        }
    }


    private boolean isSuchSessionPresent(LocalDateTime time, UUID hallId, UUID movieId) {
        SessionRepo sessionRepo = new SessionRepo();
        return sessionRepo.findAll().stream().anyMatch(session -> session.getMovie().getId().equals(movieId) && session.getHall().getId().equals(hallId) && session.getTime().equals(time));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID chosenSessionId = UUID.fromString(req.getParameter("id"));
        SessionRepo sessionRepo = new SessionRepo();
        Session chosenSession = sessionRepo.findById(chosenSessionId);
        sessionRepo.delete(chosenSession.getId());
        resp.sendRedirect("/sessionDelete.jsp");
    }
}
