#!/bin/bash

if [ -z "$ETHERPAD_TITLE" ]; then
	ETHERPAD_TITLE="Etherpad"
fi

cat > /opt/etherpad/settings.json <<EOF
{
  // Name your instance!
  "title": "$ETHERPAD_TITLE",

  // favicon default name
  // alternatively, set up a fully specified Url to your own favicon
  "favicon": "favicon.ico",

  //IP and port which etherpad should bind at
  "ip": "0.0.0.0",
  "port" : 9001,

  /*
  // Node native SSL support
  // this is disabled by default
  //
  // make sure to have the minimum and correct file access permissions set
  // so that the Etherpad server can access them

  "ssl" : {
            "key"  : "/path-to-your/epl-server.key",
            "cert" : "/path-to-your/epl-server.crt",
            "ca": ["/path-to-your/epl-intermediate-cert1.crt", "/path-to-your/epl-intermediate-cert2.crt"]
          },

  */

  //The Type of the database. You can choose between dirty, postgres, sqlite and mysql
  //You shouldn't use "dirty" for for anything else than testing or development
  "dbType" : "mysql",
  //the database specific settings
/*  "dbSettings" : {
                   "filename" : "var/dirty.db"
                 },
*/
  // An Example of MySQL Configuration
   "dbType" : "mysql",
   "dbSettings" : {
                    "user"    : "$MYSQL_ENV_DB_USER",
                    "host"    : "$MYSQL_PORT_3306_TCP_ADDR",
                    "password": "$MYSQL_ENV_DB_PASS",
                    "database": "$MYSQL_ENV_DB_NAME",
                    "charset" : "utf8mb4"
                  },
  

  //the default text of a pad
  "defaultPadText" : "Welcome to Etherpad!\n\nThis pad text is synchronized as you type, so that everyone viewing this page sees the same text. This allows you to collaborate seamlessly on documents!\n\nGet involved with Etherpad at http:\/\/etherpad.org\n",

  /* Default Pad behavior, users can override by changing */
  "padOptions": {
    "noColors": false,
    "showControls": true,
    "showChat": true,
    "showLineNumbers": true,
    "useMonospaceFont": false,
    "userName": false,
    "userColor": false,
    "rtl": false,
    "alwaysShowChat": false,
    "chatAndUsers": false,
    "lang": "en-gb"
  },

  /* Should we suppress errors from being visible in the default Pad Text? */
  "suppressErrorsInPadText" : false,

  /* Users must have a session to access pads. This effectively allows only group pads to be accessed. */
  "requireSession" : false,

  /* Users may edit pads but not create new ones. Pad creation is only via the API. This applies both to group pads and regular pads. */
  "editOnly" : false,

  /* Users, who have a valid session, automatically get granted access to password protected pads */
  "sessionNoPassword" : false,

  /* if true, all css & js will be minified before sending to the client. This will improve the loading performance massivly,
     but makes it impossible to debug the javascript/css */
  "minify" : true,

  /* How long may clients use served javascript code (in seconds)? Without versioning this
     may cause problems during deployment. Set to 0 to disable caching */
  "maxAge" : 21600, // 60 * 60 * 6 = 6 hours

  /* This is the absolute path to the Abiword executable. Setting it to null, disables abiword.
     Abiword is needed to advanced import/export features of pads*/
  "abiword" : null,

  /* This is the absolute path to the soffice executable. Setting it to null, disables LibreOffice exporting.
     LibreOffice can be used in lieu of Abiword to export pads */
  "soffice" : null,

  /* This is the path to the Tidy executable. Setting it to null, disables Tidy.
     Tidy is used to improve the quality of exported pads*/
  "tidyHtml" : null,

  /* Allow import of file types other than the supported types: txt, doc, docx, rtf, odt, html & htm */
  "allowUnknownFileEnds" : true,

  /* This setting is used if you require authentication of all users.
     Note: /admin always requires authentication. */
  "requireAuthentication" : false,

  /* Require authorization by a module, or a user with is_admin set, see below. */
  "requireAuthorization" : false,

  /*when you use NginX or another proxy/ load-balancer set this to true*/
  "trustProxy" : false,

  /* Privacy: disable IP logging */
  "disableIPlogging" : false,

  /* Users for basic authentication. is_admin = true gives access to /admin.
     If you do not uncomment this, /admin will not be available! */
  /*
  "users": {
    "admin": {
      "password": "changeme1",
      "is_admin": true
    },
    "user": {
      "password": "changeme1",
      "is_admin": false
    }
  },
  */

  // restrict socket.io transport methods
  "socketTransportProtocols" : ["xhr-polling", "jsonp-polling", "htmlfile"],

  // Allow Load Testing tools to hit the Etherpad Instance.  Warning this will disable security on the instance.
  "loadTest": false,

  // Disable indentation on new line when previous line ends with some special chars (':', '[', '(', '{')
  /*
  "indentationOnNewLine": false,
  */

  /* The toolbar buttons configuration.
  "toolbar": {
    "left": [
      ["bold", "italic", "underline", "strikethrough"],
      ["orderedlist", "unorderedlist", "indent", "outdent"],
      ["undo", "redo"],
      ["clearauthorship"]
    ],
    "right": [
      ["importexport", "timeslider", "savedrevision"],
      ["settings", "embed"],
      ["showusers"]
    ],
    "timeslider": [
      ["timeslider_export", "timeslider_returnToPad"]
    ]
  },
  */

  /* The log level we are using, can be: DEBUG, INFO, WARN, ERROR */
  "loglevel": "INFO",

  //Logging configuration. See log4js documentation for further information
  // https://github.com/nomiddlename/log4js-node
  // You can add as many appenders as you want here:
  "logconfig" :
    { "appenders": [
        { "type": "console"
        //, "category": "access"// only logs pad access
        }
    /*
      , { "type": "file"
      , "filename": "your-log-file-here.log"
      , "maxLogSize": 1024
      , "backups": 3 // how many log files there're gonna be at max
      //, "category": "test" // only log a specific category
        }*/
    /*
      , { "type": "logLevelFilter"
        , "level": "warn" // filters out all log messages that have a lower level than "error"
        , "appender":
          {  Use whatever appender you want here  }
        }*/
    /*
      , { "type": "logLevelFilter"
        , "level": "error" // filters out all log messages that have a lower level than "error"
        , "appender":
          { "type": "smtp"
          , "subject": "An error occured in your EPL instance!"
          , "recipients": "bar@blurdybloop.com, baz@blurdybloop.com"
          , "sendInterval": 60*5 // in secs -- will buffer log messages; set to 0 to send a mail for every message
          , "transport": "SMTP", "SMTP": { // see https://github.com/andris9/Nodemailer#possible-transport-methods
              "host": "smtp.example.com", "port": 465,
              "secureConnection": true,
              "auth": {
                  "user": "foo@example.com",
                  "pass": "bar_foo"
              }
            }
          }
        }*/
      ]
    }
}
EOF

# do exec as that will make process get signals...
exec supervisord -c /etc/supervisor/supervisor.conf -n
