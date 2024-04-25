package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import uz.muhammadtrying.iticketproject.entity.enums.Status;

import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@Data
@Entity
public class Seat extends BaseEntity {
    private String seatNumber;
    @Enumerated(EnumType.STRING)
    private Status status;
    @ManyToOne(cascade = CascadeType.ALL)
    private Session session;

    @Builder
    public Seat(UUID id, String seatNumber, Status status, Session session) {
        super(id);
        this.seatNumber = seatNumber;
        this.status = status;
        this.session = session;
    }
}
