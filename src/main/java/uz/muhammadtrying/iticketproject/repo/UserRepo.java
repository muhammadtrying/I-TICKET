package uz.muhammadtrying.iticketproject.repo;

import jakarta.persistence.EntityManager;
import uz.muhammadtrying.iticketproject.entity.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static uz.muhammadtrying.iticketproject.config.DataLoader.emf;


public class UserRepo extends BaseRepo<User, UUID> {
    public static Optional<User> findByName(String username) {
        EntityManager entityManager = emf.createEntityManager();
        List<User> list = entityManager.createQuery(
                        "select u from User u where u.username=:username", User.class)
                .setParameter("username", username).getResultList();
        if (list.isEmpty()) {
            return Optional.empty();
        } else {
            return Optional.of(list.get(0));
        }
    }
}
