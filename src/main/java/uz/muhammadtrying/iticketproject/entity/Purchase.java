package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.Entity;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Entity
@NoArgsConstructor
@Data
public class Purchase extends BaseEntity {
    @CreationTimestamp
    private LocalDateTime purchaseDate;
    private String movie;
    private Integer price;
    private String sessionTime;
    private String hall;

    @Builder

    public Purchase(UUID id, LocalDateTime purchaseDate, String movie, Integer price, String sessionTime, String hall) {
        super(id);
        this.purchaseDate = purchaseDate;
        this.movie = movie;
        this.price = price;
        this.sessionTime = sessionTime;
        this.hall = hall;
    }
}
