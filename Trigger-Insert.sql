
-- Table: USUARIO
CREATE TABLE USUARIO ( 
    USERNAME VARCHAR( 20 )  UNIQUE
                            NOT NULL,
    PASSWORD VARCHAR( 20 )  UNIQUE
                            NOT NULL 
);

-- Table: AUDITORIA_USUARIO
CREATE TABLE AUDITORIA_USUARIO ( 
    N                INTEGER        PRIMARY KEY AUTOINCREMENT
                                    NOT NULL,
    USERNAME_ANTES   VARCHAR( 30 )  NOT NULL,
    USERNAME_DESPUES VARCHAR( 30 )  NOT NULL,
    PASSWORD_ANTES   VARCHAR( 20 )  NOT NULL,
    PASSWORD_DESPUES VARCHAR( 20 )  NOT NULL,
    COMANDO          VARCHAR( 15 )  NOT NULL,
    FECHA_REGISTRO   DATE           NOT NULL 
);

-- Trigger: T_AUDI_USER_INSERT
CREATE TRIGGER T_AUDI_USER_INSERT
       AFTER INSERT ON USUARIO
       FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_USUARIO ( 
        USERNAME_ANTES,
        USERNAME_DESPUES,
        PASSWORD_ANTES,
        PASSWORD_DESPUES,
        COMANDO,
        FECHA_REGISTRO 
    ) 
    VALUES ( 
        'USERNAME: ' || NEW.USERNAME,
        'USERNAME: ' || NEW.USERNAME,
        'PASSWORD: ' || NEW.PASSWORD,
        'PASSWORD: ' || NEW.PASSWORD,
        'INSERT',
        datetime( 'now' ) 
    );
END;
;

-- Table: ESTUDIANTE
CREATE TABLE ESTUDIANTE ( 
    CODIGO            INTEGER        NOT NULL
                                     PRIMARY KEY AUTOINCREMENT,
    NOMBRE            VARCHAR( 25 )  NOT NULL,
    APELLIDO          VARCHAR( 25 )  NOT NULL,
    PC1               FLOAT          NULL,
    PC2               FLOAT          NULL,
    PC3               FLOAT          NULL,
    PC4               FLOAT          NULL,
    PARCIAL           FLOAT          NULL,
    FINAL             FLOAT          NULL,
    PROMEDIO          FLOAT          NOT NULL,
    FECHA_DE_REGISTRO DATE           NOT NULL,
    ESTADO            VARCHAR( 10 )  NOT NULL,
    CONDICION         VARCHAR( 12 )  NOT NULL 
);

-- Table: AUDITORIA_ESTUDIANTE
CREATE TABLE AUDITORIA_ESTUDIANTE ( 
    NUMERO         INTEGER         PRIMARY KEY AUTOINCREMENT
                                   NOT NULL,
    CODIGO_EST     INTEGER         NOT NULL,
    FECHA_REGISTRO DATE            NOT NULL,
    DATOS_ANTES    VARCHAR( 115 )  NOT NULL,
    DATOS_DESPUES  VARCHAR( 115 )  NOT NULL,
    COMANDO        VARCHAR( 15 )   NOT NULL 
);




-- Trigger: T_AUDI_EST_UPDATE
CREATE TRIGGER T_AUDI_EST_UPDATE
       AFTER UPDATE ON ESTUDIANTE
       FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_ESTUDIANTE ( 
        CODIGO_EST,
        FECHA_REGISTRO,
        DATOS_ANTES,
        DATOS_DESPUES,
        COMANDO 
    ) 
    VALUES ( 
        NEW.CODIGO,
        datetime( 'now' ),
        'NOMBRE: ' || OLD.NOMBRE || ', ' || 'APELLIDO: ' || OLD.APELLIDO || ', ' || 'PC1: ' || OLD.PC1 || ', ' || 'PC2: ' || OLD.PC2 || ', ' || 'PC3: ' || OLD.PC3 || ', ' || 'PC4: ' || OLD.PC4 || ', ' || 'PARCIAL: ' || OLD.PARCIAL || ', ' || 'FINAL: ' || OLD.FINAL || ', ' || 'ESTADO: ' || OLD.ESTADO,
        'NOMBRE: ' || NEW.NOMBRE || ', ' || 'APELLIDO: ' || NEW.APELLIDO || ', ' || 'PC1: ' || NEW.PC1 || ', ' || 'PC2: ' || NEW.PC2 || ', ' || 'PC3: ' || NEW.PC3 || ', ' || 'PC4: ' || NEW.PC4 || ', ' || 'PARCIAL: ' || NEW.PARCIAL || ', ' || 'FINAL: ' || NEW.FINAL || ', ' || 'ESTADO: ' || NEW.ESTADO,
        'UPDATE' 
    );
END;
;


-- Trigger: T_AUDI_EST_DELETE
CREATE TRIGGER T_AUDI_EST_DELETE
       AFTER DELETE ON ESTUDIANTE
       FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_ESTUDIANTE ( 
        CODIGO_EST,
        FECHA_REGISTRO,
        DATOS_ANTES,
        DATOS_DESPUES,
        COMANDO 
    ) 
    VALUES ( 
        OLD.CODIGO,
        datetime( 'now' ),
        'NOMBRE: ' || OLD.NOMBRE || ', ' || 'APELLIDO: ' || OLD.APELLIDO || ', ' || 'PC1: ' || OLD.PC1 || ', ' || 'PC2: ' || OLD.PC2 || ', ' || 'PC3: ' || OLD.PC3 || ', ' || 'PC4: ' || OLD.PC4 || ', ' || 'PARCIAL: ' || OLD.PARCIAL || ', ' || 'FINAL: ' || OLD.FINAL || ', ' || 'ESTADO: ' || OLD.ESTADO,
        'SIN DATOS NUEVOS ',
        'DELETE' 
    );
END;
;
