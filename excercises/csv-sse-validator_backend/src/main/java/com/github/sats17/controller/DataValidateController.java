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

@Path("/api")
public class DataValidateController {

    @POST
    @Path("/validate-customers")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.SERVER_SENT_EVENTS)
    @RestStreamElementType(MediaType.APPLICATION_JSON)
    public Multi<GenericValidationResponse> uploadCustomers(List<JsonNode> incomingData) {
        System.out.println("Total Records Received: " + incomingData.size());

        // Stream directly from the list of dynamic JSON nodes
        return Multi.createFrom().iterable(incomingData)
                .onItem().transform(jsonNode -> {
                    // Extract the "id" field as an int.
                    // If "id" is missing, it defaults to 0 (or you can throw an exception)
                    int id = jsonNode.has("id") ? jsonNode.get("id").asInt() : 0;

                    // Return the streamlined response
                    return new GenericValidationResponse(id, true);
                })
                // Keeps your 2-second delay per item
                .onItem().call(response ->
                        Uni.createFrom().nullItem().onItem().delayIt().by(Duration.ofMillis(2000))
                );
    }

    // Your new lightweight response structure
    public record GenericValidationResponse(
            int id,
            boolean validated
    ) {}
}