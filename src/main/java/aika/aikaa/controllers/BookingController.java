package aika.aikaa.controllers;

import aika.aikaa.daos.BookingDao;
import aika.aikaa.daos.UserDao;
import aika.aikaa.objects.Booking;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
//@PreAuthorize("hasAuthority('ROLE_SUPERADMIN') or hasAuthority('ROLE_ADMIN') or hasAuthority('ROLE_USER')")
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

    @GetMapping("/api/bookings/day/{target}/{targetid}")// "2019-07-05"
    public List<Booking> userBookingsByDay(@RequestParam String day, @PathVariable String target, @PathVariable Integer targetid) {
        if (target.equals("user")) {
            return bd.userBookingsByDay(day, targetid);
        }
        return null;
    }

    @GetMapping("/api/bookings/place/{id}")
    public List<Booking> placeBookings(@PathVariable Integer id) {
        return bd.placeBookings(id);
    }
}
