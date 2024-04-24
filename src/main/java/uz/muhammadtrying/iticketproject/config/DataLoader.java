package uz.muhammadtrying.iticketproject.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import uz.muhammadtrying.iticketproject.entity.Hall;
import uz.muhammadtrying.iticketproject.entity.Movie;
import uz.muhammadtrying.iticketproject.entity.Seat;
import uz.muhammadtrying.iticketproject.entity.Session;
import uz.muhammadtrying.iticketproject.entity.enums.Status;

import java.time.LocalDateTime;
import java.time.Month;

import static jakarta.persistence.Persistence.createEntityManagerFactory;

@WebListener
public class DataLoader implements ServletContextListener {
    public static EntityManagerFactory emf;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        emf = createEntityManagerFactory("default");
//        initData();
        ServletContextListener.super.contextInitialized(sce);
    }

    private void initData() {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();

        Hall hall1 = Hall.builder().name("3D CINEMA").build();
        Hall hall2 = Hall.builder().name("CINEMA MARK").build();
        Hall hall3 = Hall.builder().name("AFSONA").build();
        Hall hall4 = Hall.builder().name("CINERAMA").build();
        entityManager.persist(hall1);
        entityManager.persist(hall2);
        entityManager.persist(hall3);
        entityManager.persist(hall4);

        for (int i = 1; i <= 12; i++) {
            Seat seat1 = Seat.builder().seatNumber(String.valueOf(i)).status(Status.FREE).hall(hall1).build();
            Seat seat2 = Seat.builder().seatNumber(String.valueOf(i)).status(Status.FREE).hall(hall2).build();
            Seat seat3 = Seat.builder().seatNumber(String.valueOf(i)).status(Status.FREE).hall(hall3).build();
            Seat seat4 = Seat.builder().seatNumber(String.valueOf(i)).status(Status.FREE).hall(hall4).build();
            entityManager.persist(seat1);
            entityManager.persist(seat2);
            entityManager.persist(seat3);
            entityManager.persist(seat4);
        }

        Movie movie1 = Movie.builder().name("INTERSTELLAR").build();
        Movie movie2 = Movie.builder().name("OPPENHEIMER").build();
        Movie movie3 = Movie.builder().name("AVATAR").build();
        Movie movie4 = Movie.builder().name("LEON").build();
        entityManager.persist(movie1);
        entityManager.persist(movie2);
        entityManager.persist(movie3);
        entityManager.persist(movie4);

        Session session1 = Session.builder().time(LocalDateTime.of(2024, Month.MAY, 1, 0, 0)).hall(hall1).movie(movie1).build();
        Session session2 = Session.builder().time(LocalDateTime.of(2024, Month.MAY, 2, 0, 0)).hall(hall2).movie(movie2).build();
        Session session3 = Session.builder().time(LocalDateTime.of(2024, Month.MAY, 3, 0, 0)).hall(hall3).movie(movie3).build();
        Session session4 = Session.builder().time(LocalDateTime.of(2024, Month.MAY, 4, 0, 0)).hall(hall4).movie(movie4).build();
        entityManager.persist(session1);
        entityManager.persist(session2);
        entityManager.persist(session3);
        entityManager.persist(session4);

        entityManager.getTransaction().commit();
    }
}
