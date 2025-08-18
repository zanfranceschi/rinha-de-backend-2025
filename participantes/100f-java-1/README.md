# Rinha de Backend 2025 - Caio Enrique M. Freitas (Vulgo Cemf)

Uma ideia para o processamento dos pagamentos na Rinha de Backend 2025, feita de forma um pouco corrida :smile:

## Repo:
  [https://www.linkedin.com/in/caio-enrique-747621199/](https://www.linkedin.com/in/caio-enrique-747621199/)

## Tecnologias utilizadas

- Java (21)
- Spring Webflux
- KeyDB
- HAProxy (como load balancer)

## Instruções para subir local

Execute `docker-compose up --build -d` dentro dessa pasta.

O entrypoint fica em `http://localhost:9999`, tal qual as regras definem.

## Premissa básica do funcionamento

```mermaid
    graph LR
        subgraph Payment-Processor
            direction TB
            default[payment-processor-default]
            fallback[payment-processor-fallback]
        end

        subgraph backend
            direction TB
            keydb["key-db (fila e storage)"]

            subgraph api1["api1 (:8054)"]
                direction TB
                api1_workers["Workers Reativos (api1)"]
            end

            subgraph api2["api2 (:8054)"]
                direction TB
                api2_workers["Workers Reativos (api2)"]
            end
        end

        haproxy["lb (HAProxy) (:9999)"]

        %% Fluxo externo
        haproxy --> api1
        haproxy --> api2

        %% Fila interna
        api1 --> keydb
        api2 --> keydb

        %% Workers consomem da fila
        keydb --> api1_workers
        keydb --> api2_workers

        %% Workers enviam para Payment Processors
        api1_workers --> default
        api1_workers --> fallback

        api2_workers --> default
        api2_workers --> fallback

```

O projeto funciona como diagramado acima, onde o KeyDB é usado como fila, para repassagem do payload recebido aos workers,
e como armazenamento, para o endpoint `/payments-summary`.

Sobre a ideia da rinha desse ano, expresso minha reação abaixo: AAAAAAAAAWWWNNNNN
                                                                                                                                            
                                                                                                                                       *@#     . .(                                                     
                                                                (&&(#@(                                                               #@@@@@@@@@%#,                                                     
                                                                   .@@@#,                                                           #@@@@@@.                                                            
                                                                    ,   .#&&.                                                     %@@@/  ,,                                                             
                                                                           %@@&&/                                               *@@@(                                                                   
                                                                           .&@@&.                                             .%@@&                                                                     
                                                                          (@&#@@%.                                           #@@@(                                                                      
                                                                              /@@@&,                                       /@&&@#                                                                       
                                                                              #&@@@@#                                    ,@@@@%                                                                         
                                                                                   %@@@#.                               (@@@/                                                                           
                                                                                    .&@@@@@*                          .&@@&#                                                                            
                                                                                       %@@@@#.          .@@@@@@@@@@@#/@@@@*                                                                             
                                                                                         &@@@@&,  .%@@@@&((/*//,/##@@@@@@(                                                                              
                                                                                           *@@@@@@@&##//*,,,,,,,,//(##@@@*                                                                              
                                                                                            @@@@*//***,,...,,,,,****/((@@@.                                                                             
                                                                                           *@@@*,,,,,,,...,.,,,,,*****//(@@#                                                                            
                                                                                          &@@,,,,..,,*,,,,,.,,,,*********(@@@                                                                           
                                                                                        ,@@@*,,,.,,,,*****,************/(((#@@(                                                                         
                                                                                      .@@@@**,,,,...,,,************///**((((#@@*                                                                        
                                                                                     (@@@@******,,,..,,************(#/((#####&@@,                                                                       
                                                                                     .@@@***,,,,,,,**.,,,,,/*//*((((#((/#####%@@@                                                                       
                                                                                     @@@*,.,*(#(((#(//#(*,**(#%%##/*/#((#####(@@@                                                                       
                                                                                     @@*,,.,*(#%%##%(**/*##%###%%/,,*/((####(#&@@,                                                                      
                                                                                    @@((###%%%%#(&@%%/**,**(%&&&(**///(#%%%&%(@@@.                                                                      
                                                                                   &@@&&&@&&@@@@&&&#/******/(%&&##**/(%%&@@@&%&@@                                                                       
                                                                                   @@%%&&&&@@@&#*/(/*******((###%@@@@&@@@@@@&&@@%                                                                       
                                                                                  @@&#####//**************/(##(#(###(%%%%%%&&&@@*                                                                       
                                                                                  @@**/(*,,,.,,***********//(((#(/*/#%%%#%&&@@@@                                                                        
                                                                                 @@(**********,,**//***////*//(((((/***/(#&&&@@@                                                                        
                                                                                ,@@(/****,,,,,*/*******/((/((((#####((((((##@@@*                                                                        
                                                                                @@&((//(//***,,,*****/#############%#(####%%@@@.                                                                        
                                                                                @@%##((/******,,,,,,,,**/(((#######%%####%%&@@@                                                                         
                                                                               (@@(##(/******,,,,,,..,,,,***/((#######%%%%&%@@/                                                                         
                                                                               @@%(##(//*******,..,,,,,,***/(########%%&&&&(@@                                                                          
                                                                              .@@(#(#((############(((######%%%###%%%%&&&%%@@*                                                                          
                                                                              #@@#((##(#%%&@@@@@@@@@@@@&@&&@&&&&&&&%%&&%##&@@                                                                           
                                                                              @@@(###((**/(&@@@@@@@@@@@@@@@@@@@&&&&&&&%###@@@                                                                           
                                                                              @@@#####(/**/%@@@@@@@@@@@@@@@@@@@&@&&&&%###(@@*                                                                           
                                                                             ,@@&######/*,*/%@@@@@&@@@@@@@@@&%%%%%&%%####@@&                                                                            
                                                                             /@@/#######/*,,*/##&%&@&@@%&%#%###%%%%%####@@@                                                                             
                                                                             (@@##########(/**,,,*((**///(///#%%%%######@@@                                                                             
                                                                           #@@@@%%#######################%%&&&&%%#######@@&                                                                             
                                                                        .@@@%%&&%%#%#############%%%%%%%&&@@&%%######(/*@@@,                                                                            
                                                                *@@@@@@@@%%%%%%&&%%#########%%%#######################(((@@@@@@@@@(                                                                     
                                                      @@@@@%. .@@&&&&%&&&&@@@@@&&%%%%%%%%###############(###############@@@#&%&%%%@@@@.                                                                 
                                                     ,@@%&&&&@@%&&@@@@@@@&,  @@@&&&&%%%%%#%#########################(((@@@. @@@&%%%%%@@@                                                                
                                                      (@@%%%%%%%@@%          @@@&&&&%%%%%%%%#########################(%@@@    (@@&&%%&@@@                                                               
                                                        @@@@@@@@*            %@@&&&&%%%%%%%##########################(@@@/     @@@&&&%&@@,                                                              
                                                           ...               .@@(&&&%&%%%%%##########################&@@@       @@&&%&&@@/                                                              
                                                                              ,@@@@&%&%%%%###########################@@@&       @@@&%%&@@,                                                              
                                                                               (@@@&%%%%%%##########################(@@@         @@%&&&@@@@,                                                            
                                                                                @@@&%###%%######(####(#(((########(##@@@         .@@@%%%%%&@@@@@                                                        
                                                                                 (@@&%##########(###(#(((((((#(###((#@@@(          #@@@&%&%%@@@#                                                        
                                                                                  @@&%#%%##((/((##(#((((((/****///*/*@@@@              *&@&%/                                                           
                                                                                  .@@@@@@@@@@@@@@@@&&%#####(,*,,,,*/(&@@&                                                                               
                                                                                                   ,.,         .**,,. *.                                                                                
                                                                                                                                                                                                     








