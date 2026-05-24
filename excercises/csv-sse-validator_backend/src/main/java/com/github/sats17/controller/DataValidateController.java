package com.github.sats17.controller;

import com.fasterxml.jackson.databind.JsonNode;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.jboss.resteasy.reactive.RestStreamElementType;

import java.time.Duration;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Path("/api")
public class DataValidateController {

    @POST
    @Path("/validate-customers")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.SERVER_SENT_EVENTS)
    @RestStreamElementType(MediaType.APPLICATION_JSON)
    public Multi<GenericValidationResponse> uploadCustomers(List<JsonNode> incomingData) {
        // Using JsonNode to handle dynamic JSON structure.
        System.out.println("Total Records Received: " + incomingData.size());
        return Multi.createFrom().iterable(incomingData)
                .onItem().transformToUniAndMerge(jsonNode -> {
                    int id = jsonNode.has("id") ? jsonNode.get("id").asInt() : 0;
                    // different delay per item
                    long delay = ThreadLocalRandom.current().nextLong(1000, 5000);
                    GenericValidationResponse response = new GenericValidationResponse(id, true);
                    // Mimicking processing time with a random delay
                    return Uni.createFrom().item(response).onItem().delayIt().by(Duration.ofMillis(delay));
                });
    }

    public record GenericValidationResponse(int id, boolean validated) {
    }
}