package uz.muhammadtrying.iticketproject.entity;

import jakarta.persistence.Entity;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@NoArgsConstructor
public class Movie extends BaseEntity {
    private String name;
    @Builder
    public Movie(UUID id, String name) {
        super(id);
        this.name = name;
    }
}
