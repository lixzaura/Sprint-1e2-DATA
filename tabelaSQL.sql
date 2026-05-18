CREATE TABLE TB_USUARIO_CONQUISTA(
    usuario_conquista_id         INTEGER GENERATED ALWAYS AS IDENTITY,
    data_conquista               DATE NOT NULL,
    TB_USUARIO_usuario_id        INTEGER NOT NULL,
    TB_COQNUISTA_conquista_id    INTEGER NOT NULL,
    CONSTRAINT TB_USUARIO_CONQUISTA_PK PRIMARY  KEY(usuario_conquista_id),
    CONSTRAINT TBUSUARIO_CONQUISTAUSUARIO_FK
        FOREIGN KEY (TB_USUARIO_usuario_id)
        REFERENCES TB_USUARIO(usuario_id),
    CONSTRAINT TBUSUARIOCONQUISTA_CONQUISTAFK
        FOREIGN KEY (TB_CONQUISTA_conquista_id)
        REFERENCES TB_CONQUISTA(conquista_id)
    );
        

CREATE TABLE TB_USUARIO(
    usuario_id      INTEGER GENERATED ALWAYS AS IDENTITY,
    nome            VARCHAR2(150) NOT NULL,
    pontos          INTEGER,
    creditos        NUMBER(6,2) NOT NULL,
    email           VARCHAR2(150) NOT NULL,
    data_cadastro   DATE NOT NULL,
    CONSTRAINT TB_USUARIO_PK PRIMARY KEY(usuario_id)
); 

CREATE TABLE TB_CONQUISTA(
    conquista_id    INTEGER GENERATED ALWAYS AS IDENTITY,
    nome            VARCHAR2(150) NOT NULL,
    tipo            VARCHAR2(100) NOT NULL,
    descricao       VARCHAR2(200) NOT NULL,
    
    CONSTRAINT TB_CONQUISTA_PK PRIMARY KEY (conquista_id)
); 

CREATE TABLE TB_PONTOS(
    pontos_id               INTEGER GENERATED ALWAYS AS IDENTITY,
    origem                  VARCHAR2(50) NOT NULL,
    data_pontuacao          DATE DEFAULT SYSDATE,
    creditos_gerados        NUMBER(6,2) NOT NULL,
    TB_USUARIO_usuario_id   INTEGER NOT NULL, 
    
    CONSTRAINT TB_PONTOS_PK PRIMARY KEY (pontos_id),
    CONSTRAINT TB_PONTOS_TB_USUARIO_FK, 
        FOREIGN KEY (TB_USUARIO_usuario_id),
        REFERENCES TB_USUARIO(usuario_id)
); 

CREATE TABLE TB_VIAGEM(
    viagem_id           INTEGER GENERATED ALWAYS AS IDENTITY, 
    data_viagem         DATE NOT NULL,
    origem              VARCHAR2(250) NOT NULL,
    destino             VARCHAR(250) NOT NULL,
    tipo_veiculo        VARCHAR2(50) NOT NULL, 
    km_percorrido       NUMBER(4,3) NOT NULL, 
    carbono_emitido     NUMBER(6,2) NOT NULL,
    carbono_economizado NUMBER(6,2) NOT NULL, 
    TB_USUARIO_usuario_id INTEGER NOT NULL, 
    
    CONSTRAINT TB_VIAGEM_PK PRIMARY KEY (viagem_id), 
    CONSTRAINT TB_VIAGEM_TB_USUARIO_FK
        FOREIGN KEY (TB_USUARIO_usuario_id)
        REFERENCES TB_USUARIO(usuario_id)
);

CREATE TABLE TB_USUARIO_MISSAO(
    usuario_missao_id           INTEGER GENERATED ALWAYS AS IDENTIFY, 
    data_cumprimento            DATE NOT NULL,
    status                      VARCHAR2(30) NOT NULL,
    pontuacao_recebida          INTEGER,
    TB_USUARIO_usuario_id       INTEGER NOT NULL,
    TB_MISSAO_missao_id         INTEGER NOT NULL,
    TB_VIAGEM_viagem_id         INTEGER,
    
    CONSTRAINT TB_USUARIO_MISSAO_PK PRIMARY KEY (usuario_missao_id), 
    CONSTRAINT TB_USUARIOMISSAO_USUARIO_FK
        FOREIGN KEY (TB_USUARIO_usuario_id)
         REFERENCES TB_USUARIO(usuario_id),
    CONSTRAINT TB_USUARIOMISSAO_MISSAOFK
         FOREIGN KEY (TB_MISSAO_missao_id)
          REFERENCES TB_MISSAO(missao_id),
    CONSTRAINT TB_USUARIOMISSAO_VIAGEM_FK 
        FOREIGN KEY (TB_VIAGEM_viagem_id)
        REFERENCES TB_VIAGEM(viagem_id)
);

CREATE TABLE TB_MISSAO(
    missao_id       INTEGER GENERATED ALWAYS AS IDENTITY, 
    titulo          VARCHAR2(150)NOT NULL,
    tipo_missao     VARCHAR2(30)NOT NULL,
    descricao       VARCHAR(150)NOT NULL,
    pontos_missao   INTEGER GENERATED ALWAYS AS IDENTITY,
    
    CONSTRAINT TB_MISSAO_PK PRIMARY KEY (missao_id)
);






    
    