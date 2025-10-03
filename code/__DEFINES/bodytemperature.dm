#define TEMPERATURE_DAMAGE_COEFFICIENT      1.5
#define BODYTEMP_NORMAL                     37      // Normal body temperature in Celsius
#define BODYTEMP_AUTORECOVERY_DIVISOR       22
#define BODYTEMP_AUTORECOVERY_MINIMUM       1       // 1 degree per tick minimum recovery
#define BODYTEMP_COLD_DIVISOR               12
#define BODYTEMP_HEAT_DIVISOR               30
#define BODYTEMP_COOLING_MAX                -5      // Max 5 degrees cooling per tick
#define BODYTEMP_HEATING_MAX                3       // Max 3 degrees heating per tick
#define BODYTEMP_MAX_TEMPERATURE            80      // Death from heat
#define BODYTEMP_MIN_TEMPERATURE            -10     // Death from cold
#define BODYTEMP_HEAT_DAMAGE_LIMIT          49
#define BODYTEMP_COLD_DAMAGE_LIMIT          10

#define AMBIENT_COMFORT_MIN             18      // Below this, you feel cool
#define AMBIENT_COMFORT_MAX             26      // Above this, you feel warm
