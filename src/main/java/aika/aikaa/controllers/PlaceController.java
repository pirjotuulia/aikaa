package aika.aikaa.controllers;

import aika.aikaa.daos.PlaceDao;
import aika.aikaa.objects.Place;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PlaceController {
    private PlaceDao pd;

    public PlaceController(@Autowired PlaceDao userDao) {
        this.pd = userDao;
    }

    @GetMapping("/api/places")
    public List<Place> allPlaces() {
        return pd.listOfAllPlaces();
    }

    @GetMapping("/api/places/{id}")
    public Place placeById(@PathVariable Integer id) {
        return pd.onePlace(id);
    }
    @PostMapping("/api/places")
    public Place addPlace(@RequestBody Place place) {
        return pd.createPlace(place);
    }

    @PutMapping("/api/places/{id}")
    public boolean updatePlace(@RequestBody Place place, @PathVariable Integer id) {
        return pd.updatePlace(place, id);
    }

    @DeleteMapping("/api/places/{id}")
    public boolean deletePlace(@PathVariable Integer id) {
        return pd.deletePlace(id);
    }
}
