package aika.aikaa.controllers;

import aika.aikaa.daos.BookingDao;
import aika.aikaa.daos.UserDao;
import aika.aikaa.objects.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class BookingController {
    private BookingDao bd;

    public BookingController(@Autowired BookingDao bookingDao) {
        this.bd = bookingDao;
    }

    @GetMapping("/api/bookings")
    public List<Booking> allBookings() {
        return bd.allBookings();
    }

    @GetMapping("/api/bookings/user/{id}")
    public List<Booking> userBookings(@PathVariable Integer id) {
        return bd.userBookings(id);
    }
}
