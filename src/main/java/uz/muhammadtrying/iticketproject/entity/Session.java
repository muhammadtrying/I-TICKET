package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@NoArgsConstructor
public class Session extends BaseEntity {
    private LocalDateTime time;
    @ManyToOne
    private Movie movie;
    @ManyToOne
    private Hall hall;

    @Builder
    public Session(UUID id, LocalDateTime time, Movie movie, Hall hall) {
        super(id);
        this.time = time;
        this.movie = movie;
        this.hall = hall;
    }
}
