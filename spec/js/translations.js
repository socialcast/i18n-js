;(function(){
  var generator = function() {
    var Translations = {};

    Translations.en = {
        hello: "Hello World!"
      , empty: ""
      , greetings: {
            stranger: "Hello stranger!"
          , name: "Hello {{name}}!"
        }

      , profile: {
          details: "{{name}} is {{age}}-years old"
        }

      , inbox: {
            one: "You have {{count}} message"
          , other: "You have {{count}} messages"
          , zero: "You have no messages"
        }

      , unread: {
            one: "You have 1 new message ({{unread}} unread)"
          , other: "You have {{count}} new messages ({{unread}} unread)"
          , zero: "You have no new messages ({{unread}} unread)"
        }

      , number: {
          human: {
            storage_units: {
                units: {
                  "byte": {
                      one: "Byte"
                    , other: "Bytes"
                  }
                , "kb": "KB"
                , "mb": "MB"
                , "gb": "GB"
                , "tb": "TB"
              }
            }
          }
        }
    };

    Translations["en-US"] = {
      date: {
          formats: {
              "default": "%d/%m/%Y"
            , "short": "%d de %B"
            , "long": "%d de %B de %Y"
          }

        , day_names: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        , abbr_day_names: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        , month_names: [null, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        , abbr_month_names: [null, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
        , meridian: ["am", "pm"]
      }
    };

    Translations["pt-BR"] = {
        hello: "Olá Mundo!"

      , number: {
          percentage: {
            format: {
                delimiter: ""
              , separator: ","
              , precision: 2
            }
          }
        }

      , date: {
          formats: {
              "default": "%d/%m/%Y"
            , "short": "%d de %B"
            , "long": "%d de %B de %Y"
          }
          , day_names: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
          , abbr_day_names: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"]
          , month_names: [null, "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
          , abbr_month_names: [null, "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
        }

      , time: {
            formats: {
                "default": "%A, %d de %B de %Y, %H:%M h"
              , "short": "%d/%m, %H:%M h"
              , "long": "%A, %d de %B de %Y, %H:%M h"
            }
          , am: "AM"
          , pm: "PM"
        }
    };

    Translations["de"] = {
      hello: "Hallo Welt!"
    };

    Translations["nb"] = {
      hello: "Hei Verden!"
    };

    return Translations;
  };

  if (typeof(exports) === "undefined") {
    window.Translations = generator;
  } else {
    module.exports = generator;
  }
})();
