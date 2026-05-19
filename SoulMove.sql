CREATE TABLE TB_USUARIO (
    usuario_id    INTEGER      GENERATED ALWAYS AS IDENTITY,
    nome          VARCHAR(150) NOT NULL,
    pontos        INTEGER      NOT NULL,
    creditos      NUMERIC(6,2) NOT NULL,
    email         VARCHAR(150) NOT NULL,
    data_cadastro DATE         NOT NULL, 
    CONSTRAINT TB_USUARIO_PK PRIMARY KEY (usuario_id)
);

DROP TABLE TB_USUARIO

CREATE TABLE TB_CONQUISTA (
    conquista_id    INTEGER      GENERATED ALWAYS AS IDENTITY,
    nome            VARCHAR(150) NOT NULL,
    tipo            VARCHAR(100) NOT NULL,
    descricao       VARCHAR(200) NOT NULL,
    CONSTRAINT TB_CONQUISTA_PK PRIMARY KEY (conquista_id),
    CONSTRAINT TB_CONQUISTA_TIPO 
            CHECK(tipo in ('missoes', 'ranking'))
);

DROP TABLE TB_CONQUISTA

CREATE TABLE TB_USUARIO_CONQUISTA (
    usuario_id      INTEGER NOT NULL,
    conquista_id    INTEGER NOT NULL,
    data_conquista  DATE    NOT NULL,
    CONSTRAINT TB_USUARIO_CONQUISTA_USUARIO_PK
        FOREIGN KEY (usuario_id)
        REFERENCES TB_USUARIO (usuario_id),
    CONSTRAINT TB_USUARIO_CONQUISTA_CONQUISTA_PK
        FOREIGN KEY (conquista_id)
        REFERENCES TB_CONQUISTA (conquista_id),
    UNIQUE(conquista_id, data_conquista)
);

DROP TABLE TB_USUARIO_CONQUISTA

CREATE TABLE TB_PONTOS (
    pontos_id        INTEGER      GENERATED ALWAYS AS IDENTITY,
    usuario_id       INTEGER      NOT NULL,
    origem           VARCHAR(50)  NOT NULL,
    data_pontuacao   DATE         NOT NULL,
    creditos_gerados NUMERIC(6,2) NOT NULL,
    CONSTRAINT TB_PONTOS_PK PRIMARY KEY (pontos_id),
    CONSTRAINT TB_PONTOS_USUARIO_PK
        FOREIGN KEY (usuario_id)
        REFERENCES TB_USUARIO (usuario_id)
);

DROP TABLE TB_PONTOS

CREATE TABLE TB_MISSAO (
    missao_id     INTEGER       GENERATED ALWAYS AS IDENTITY,
    titulo        VARCHAR(150)  NOT NULL,
    tipo_missao   VARCHAR(30)   NOT NULL,
    descricao     VARCHAR(150)  NOT NULL,
    pontos_missao INTEGER       NOT NULL,
    CONSTRAINT TB_MISSAO_PK PRIMARY KEY (missao_id)
);

DROP TABLE TB_MISSAO

CREATE TABLE TB_VIAGEM (
    viagem_id           INTEGER          GENERATED ALWAYS AS IDENTITY,
    usuario_id          INTEGER          NOT NULL,
    data_viagem         DATE             NOT NULL,
    origem              VARCHAR(250)     NOT NULL,
    destino             VARCHAR(250)     NOT NULL,
    tipo_veiculo        VARCHAR(50)      NOT NULL,
    km_percorrido       NUMERIC(4,3)     NOT NULL,
    carbono_emitido     NUMERIC(6,2)     NOT NULL,
    carbono_economizado NUMERIC(6,2)     NOT NULL,
    CONSTRAINT TB_VIAGEM_PK PRIMARY KEY (viagem_id),
    CONSTRAINT TB_VIAGEM_USUARIO_PK
        FOREIGN KEY (usuario_id)
        REFERENCES TB_USUARIO (usuario_id),
    CONSTRAINT TB_VIAGEM_CK
        CHECK (tipo_veiculo in ('bicicleta', 'carro', 'metro', 'moto', 'onibus', 'trem'))
);

DROP TABLE TB_VIAGEM

CREATE TABLE TB_USUARIO_MISSAO (
    usuario_id         INTEGER     NOT NULL,
    missao_id          INTEGER     NOT NULL,
    viagem_id          INTEGER     NOT NULL,
    status_missao      VARCHAR(30) NOT NULL,
    data_cumprimento   DATE        NOT NULL,
    pontuacao_recebida INTEGER     NOT NULL,
    CONSTRAINT TB_USUARIO_MISSAO_USUARIO
        FOREIGN KEY (usuario_id)
        REFERENCES TB_USUARIO (usuario_id),
    CONSTRAINT TB_USUARIO_MISSAO_MISSAO
        FOREIGN KEY (missao_id)
        REFERENCES TB_MISSAO (missao_id),
    CONSTRAINT TB_USUARIO_MISSAO_VIAGEM
        FOREIGN KEY (viagem_id)
        REFERENCES TB_VIAGEM (viagem_id),
    CONSTRAINT TB_USUARIO_MISSAO_CK
        CHECK (status_missao in ('concluida', 'cancelada', 'em_andamento', 'pendente'))
);

DROP TABLE TB_USUARIO_MISSAO