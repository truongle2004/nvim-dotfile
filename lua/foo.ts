export const schema = {
  title: "Longitude and Latitude Values",
  description: "A geographical coordinate",
  required: ["Latitude", "Longitude"],
  type: "object",
  properties: {
    Latitude: {
      type: "number",
      minimum: -90,
      maximum: 90,
    },
    Longitude: {
      type: "number",
      minimum: -180,
      maximum: 180,
    },
  },
};
