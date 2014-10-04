module.exports = [
  {
    type:    'checkbox'
    name:    'extendTools'
    message: 'Select the additional tools you would like to use'
    choices: [
      { checked: true, value: 'npm|ractive',       name: 'Ractive      - Template-driven, reactive UI library' }
      { checked: true, value: 'bower|foundation',  name: 'Foundation   - Responsive HTML/CSS front-end framework' }
      { checked: true, value: 'npm|cheerio',       name: 'Cheerio      - Implementation of core jQuery for the server (for testing)' }
    ]
  }
]
