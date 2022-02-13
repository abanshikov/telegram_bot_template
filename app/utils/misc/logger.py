import logging.config

FILE_LOG = 'logs.log'
LEVEL_FILE = 'WARNING'
LEVEL_CONSOLE = 'DEBUG'

logging.getLogger('urllib3').setLevel('CRITICAL')
logger_config = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'file_format': {
            'format': '{levelname}: \t{asctime} {filename} {funcName}(): #{lineno}\t{message}',
            'style': '{',
        },
        'console_format': {
            'format': '%(levelname)s: \t%(asctime)s.%(msecs)03d %(filename)s %(funcName)s(): #%(lineno)s\t%(message)s',
            'datefmt': '%H:%M:%S',
        }
    },
    'handlers': {
        'file': {
            'class': 'logging.FileHandler',
            'level': LEVEL_FILE,
            'filename': FILE_LOG,
            'mode': 'w',
            'formatter': 'file_format',
        },
        'console': {
            'class': 'logging.StreamHandler',
            'level': LEVEL_CONSOLE,
            'formatter': 'console_format',
        },
    },
    'loggers': {
        'logs.log': {
            'level': 'DEBUG',
            'handlers': ['file', 'console'],
            'propagate': False,
        }
    },
    'filters': {},
    'root': {},
}
logging.config.dictConfig(logger_config)
log = logging.getLogger('logs.log')
