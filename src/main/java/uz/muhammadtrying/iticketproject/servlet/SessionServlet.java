package uz.muhammadtrying.iticketproject.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.Hall;
import uz.muhammadtrying.iticketproject.entity.Movie;
import uz.muhammadtrying.iticketproject.entity.Session;
import uz.muhammadtrying.iticketproject.repo.HallRepo;
import uz.muhammadtrying.iticketproject.repo.MovieRepo;
import uz.muhammadtrying.iticketproject.repo.SessionRepo;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

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
            Session session = Session.builder()
                    .movie(movie)
                    .hall(hall)
                    .time(time)
                    .build();
            sessionRepo.save(session);
        }
        resp.sendRedirect("/sessionCrud.jsp");
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
