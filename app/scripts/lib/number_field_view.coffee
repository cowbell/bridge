@Bridge.NumberField = Ember.TextField.extend
  type: "number",
  attributeBindings: ["min", "max", "step", "required"]
