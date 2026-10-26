//
//  ViewController.m
//  Lucid TikTok Settings
//

#import "ViewController.h"
#import "CountryTable.h"
#import "LiveActions.h"
#import "PlaybackSpeed.h"

@interface ViewController ()
@property (nonatomic, strong) UITableView *staticTable;
@property (nonatomic, assign) BOOL isAdditionalCellVisible;
@property (nonatomic, assign) UIImage *devImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.05 alpha:1.0];
    self.title = @"Lucid TikTok";
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.05 alpha:1.0];
        appearance.titleTextAttributes = @{
            NSForegroundColorAttributeName: [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0]
        };
        appearance.largeTitleTextAttributes = @{
            NSForegroundColorAttributeName: [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0]
        };
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.compactAppearance = appearance;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
    }
    
    self.staticTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.staticTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.staticTable.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.05 alpha:1.0];
    self.staticTable.separatorColor = [UIColor colorWithWhite:0.18 alpha:1.0];
    [self.view addSubview:self.staticTable];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.staticTable.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.staticTable.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.staticTable.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.staticTable.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
    self.staticTable.dataSource = self;
    self.staticTable.delegate = self;
    self.staticTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(regionSelected:)
                                                 name:@"RegionSelectedNotification"
                                               object:nil];
}

- (void)regionSelected:(NSNotification *)notification {
    [self.staticTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Feed & Otimização de Bateria";
        case 1:
            return @"Perfil";
        case 2:
            return @"Confirmações de Ação";
        case 3:
            return @"Recursos Avançados";
        case 4:
            return @"Região";
        case 5:
            return @"Botão Live";
        case 6:
            return @"Velocidade de Reprodução";
        case 7:
            return @"Sobre o Lucid TikTok";
        default:
            break;
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.textLabel.textColor = [UIColor colorWithWhite:0.65 alpha:1.0];
        header.textLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: // Feed section
            return 15;
        case 1: // Profile section
            return 4;
        case 2: // Confirm section
            return 4;
        case 3: // Other section
            return 10;
        case 4:
            return 2; // region section
        case 5:
            return 2; // live action section
        case 6:
            return 2;
        case 7:
            return 3; // Lucid info section
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return [self createSwitchCellWithTitle:@"Bloquear Anúncios"
                                                Detail:@"Elimina anúncios de vídeo e banners comerciais (economiza bateria e dados)"
                                                   Key:@"hide_ads"];
            case 1:
                return [self createSwitchCellWithTitle:@"Botão de Download"
                                                Detail:@"Habilita botão de download direto nos vídeos"
                                                   Key:@"download_button"];
            case 2:
                return [self createSwitchCellWithTitle:@"Menu Compartilhar"
                                                Detail:@"Opções diretas no menu nativo de compartilhamento"
                                                   Key:@"share_sheet"];
            case 3:
                return [self createSwitchCellWithTitle:@"Sem Marca D'água"
                                                Detail:@"Remove marca d'água oficial do TikTok ao baixar vídeos"
                                                   Key:@"remove_watermark"];
            case 4:
                return [self createSwitchCellWithTitle:@"Modo Pure / Limpar Interface"
                                                Detail:@"Botão para ocultar todos os botões e texto com 1 toque (desliga pixels OLED)"
                                                   Key:@"remove_elements_button"];
            case 5:
                return [self createSwitchCellWithTitle:@"Pausar ao Rolar"
                                                Detail:@"Pausa vídeo automaticamente se desejar"
                                                   Key:@"stop_play"];
            case 6:
                return [self createSwitchCellWithTitle:@"Auto Play Próximo Vídeo"
                                                Detail:@"Avança para o próximo vídeo automaticamente ao terminar"
                                                   Key:@"auto_play"];
            case 7:
                return [self createSwitchCellWithTitle:@"Barra de Progresso"
                                                Detail:@"Exibe barra de progresso arrastável em todos os vídeos"
                                                   Key:@"show_porgress_bar"];
            case 8:
                return [self createSwitchCellWithTitle:@"Comentários Translúcidos"
                                                Detail:@"Torna o painel de comentários levemente transparente"
                                                   Key:@"transparent_commnet"];
            case 9:
                return [self createSwitchCellWithTitle:@"Exibir Nomes de Usuário"
                                                Detail:@"Mostra @ de usuário claramente nos vídeos"
                                                   Key:@"show_username"];
            case 10:
                return [self createSwitchCellWithTitle:@"Desativar Aviso de Conteúdo Sensível"
                                                Detail:@"Desativa confirmação em vídeos sinalizados"
                                                   Key:@"disable_unsensitive"];
            case 11:
                return [self createSwitchCellWithTitle:@"Desativar Avisos e Alertas"
                                                Detail:@"Elimina popups intrusivos e avisos repetitivos do TikTok"
                                                   Key:@"disable_warnings"];
            case 12:
                return [self createSwitchCellWithTitle:@"Desativar Live Streaming"
                                                Detail:@"Bloqueia streams ao vivo no feed (grande economia de bateria e CPU/GPU)"
                                                   Key:@"disable_live"];
            case 13:
                return [self createSwitchCellWithTitle:@"Pular Recomendações Extras"
                                                Detail:@"Evita carregamento de feeds promocionais em segundo plano"
                                                   Key:@"skip_recommnedations"];
            case 14:
                return [self createSwitchCellWithTitle:@"Bandeira da Região de Upload"
                                                Detail:@"Exibe bandeira do país de upload junto ao nome do criador"
                                                   Key:@"upload_region"];
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                return [self createSwitchCellWithTitle:@"Salvar Foto de Perfil"
                                                Detail:@"Permite salvar a foto de perfil de qualquer usuário em alta resolução"
                                                   Key:@"save_profile"];
            case 1:
                return [self createSwitchCellWithTitle:@"Copiar Bio"
                                                Detail:@"Permite copiar a biografia de perfis para a área de transferência"
                                                   Key:@"copy_profile_information"];
            case 2:
                return [self createSwitchCellWithTitle:@"Contagem Exata de Curtidas"
                                                Detail:@"Exibe o número exato de likes no vídeo"
                                                   Key:@"video_like_count"];
            case 3:
                return [self createSwitchCellWithTitle:@"Data de Upload do Vídeo"
                                                Detail:@"Exibe a data e hora exatas da postagem do vídeo"
                                                   Key:@"video_upload_date"];
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                return [self createSwitchCellWithTitle:@"Confirmar Curtida de Vídeo"
                                                Detail:@"Exibe confirmação antes de curtir (evita like acidental)"
                                                   Key:@"like_confirm"];
            case 1:
                return [self createSwitchCellWithTitle:@"Confirmar Curtida de Comentário"
                                                Detail:@"Exibe confirmação antes de curtir um comentário"
                                                   Key:@"like_comment_confirm"];
            case 2:
                return [self createSwitchCellWithTitle:@"Confirmar Descurtida de Comentário"
                                                Detail:@"Exibe confirmação antes de descurtir um comentário"
                                                   Key:@"dislike_comment_confirm"];
            case 3:
                return [self createSwitchCellWithTitle:@"Confirmar Seguir"
                                                Detail:@"Exibe confirmação antes de seguir um usuário"
                                                   Key:@"follow_confirm"];
            default:
                break;
        }
    } else if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                return [self createSwitchCellWithTitle:@"Sempre Abrir no Safari"
                                                Detail:@"Abre links externos diretamente no Safari nativo"
                                                   Key:@"openInBrowser"];
            case 1:
                return [self createSwitchCellWithTitle:@"Modificações Locais de Perfil"
                                                Detail:@"Permite customizar números exibidos no seu próprio perfil"
                                                   Key:@"en_fake"];
            case 2: {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                
                UILabel *followerLabel = [[UILabel alloc] init];
                followerLabel.text = @"Seguidores:";
                followerLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                followerLabel.font = [UIFont systemFontOfSize:16];
                followerLabel.translatesAutoresizingMaskIntoConstraints = NO;
                [cell.contentView addSubview:followerLabel];
                
                UITextField *textField = [[UITextField alloc] init];
                textField.placeholder = @"Número de seguidores";
                textField.backgroundColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.16 alpha:1.0];
                textField.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.delegate = self;
                textField.tag = 2;
                textField.returnKeyType = UIReturnKeyDone;
                textField.translatesAutoresizingMaskIntoConstraints = NO;
                [cell.contentView addSubview:textField];
                
                [NSLayoutConstraint activateConstraints:@[
                    [followerLabel.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:15],
                    [followerLabel.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
                    [followerLabel.widthAnchor constraintEqualToConstant:100],
                    
                    [textField.leadingAnchor constraintEqualToAnchor:followerLabel.trailingAnchor constant:10],
                    [textField.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-15],
                    [textField.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
                    [textField.heightAnchor constraintEqualToConstant:34]
                ]];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *savedText = [defaults stringForKey:@"follower_count"];
                if (savedText) {
                    textField.text = savedText;
                }
                
                return cell;
            }
            case 3: {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                
                UILabel *followingLabel = [[UILabel alloc] init];
                followingLabel.text = @"Seguindo:";
                followingLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                followingLabel.font = [UIFont systemFontOfSize:16];
                followingLabel.translatesAutoresizingMaskIntoConstraints = NO;
                [cell.contentView addSubview:followingLabel];
                
                UITextField *textField = [[UITextField alloc] init];
                textField.placeholder = @"Número de seguindo";
                textField.backgroundColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.16 alpha:1.0];
                textField.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                textField.borderStyle = UITextBorderStyleRoundedRect;
                textField.delegate = self;
                textField.tag = 1;
                textField.returnKeyType = UIReturnKeyDone;
                textField.translatesAutoresizingMaskIntoConstraints = NO;
                [cell.contentView addSubview:textField];
                
                [NSLayoutConstraint activateConstraints:@[
                    [followingLabel.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:15],
                    [followingLabel.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
                    [followingLabel.widthAnchor constraintEqualToConstant:100],
                    
                    [textField.leadingAnchor constraintEqualToAnchor:followingLabel.trailingAnchor constant:10],
                    [textField.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-15],
                    [textField.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
                    [textField.heightAnchor constraintEqualToConstant:34]
                ]];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *savedText = [defaults stringForKey:@"following_count"];
                if (savedText) {
                    textField.text = savedText;
                }
                
                return cell;
            }
            case 4:
                return [self createSwitchCellWithTitle:@"Selo Verificado Falso"
                                                Detail:@"Exibe selo de verificação localmente no seu perfil"
                                                   Key:@"fake_verify"];
            case 5:
                return [self createSwitchCellWithTitle:@"Bio Expandida"
                                                Detail:@"Aumenta limite de caracteres na bio"
                                                   Key:@"extended_bio"];
            case 6:
                return [self createSwitchCellWithTitle:@"Comentários Longos"
                                                Detail:@"Aumenta o limite de caracteres ao digitar comentários"
                                                   Key:@"extendedComment"];
            case 7:
                return [self createSwitchCellWithTitle:@"Upload em Alta Definição"
                                                Detail:@"Força upload de vídeos na qualidade máxima"
                                                   Key:@"upload_hd"];
            case 8:
                return [self createSwitchCellWithTitle:@"Bloqueio por Senha (App Lock)"
                                                Detail:@"Solicita senha ao abrir o app"
                                                   Key:@"padlock"];
            case 9:
                return [self createSwitchCellWithTitle:@"Depurador FLEX"
                                                Detail:@"Apenas para desenvolvedores (não ative sem necessidade)"
                                                   Key:@"flex_enebaled"];
            default:
                break;
        }
    } else if (indexPath.section == 4) {
        switch (indexPath.row) {
            case 0:
                return [self createSwitchCellWithTitle:@"Ativar Mudança de Região"
                                                Detail:@"Permite simular outra região geográfica"
                                                   Key:@"en_region"];
            case 1: {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                UITableViewCell *regions = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
                regions.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                regions.textLabel.text = @"Região Selecionada";
                regions.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                NSDictionary *selectedRegion = [defaults dictionaryForKey:@"region"];
                regions.detailTextLabel.text = selectedRegion[@"area"] ? [NSString stringWithFormat:@"%@", selectedRegion[@"area"]] : @"Toque para selecionar";
                regions.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
                regions.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return regions;
            }
            default:
                break;
        }
    } else if (indexPath.section == 5) {
        switch (indexPath.row) {
            case 0:
                return [self createSwitchCellWithTitle:@"Personalizar Botão Live"
                                                Detail:@"Altera o comportamento padrão do botão de Live no topo"
                                                   Key:@"en_livefunc"];
            case 1: {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                UITableViewCell *liveAction = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
                liveAction.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                liveAction.textLabel.text = @"Ação do Botão";
                liveAction.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                NSString *selectedLiveAction = [defaults valueForKey:@"live_action"];
                NSArray *liveFuncTitles = @[@"Padrão", @"Lucid Settings", @"Velocidade de Reprodução"];
                if (selectedLiveAction != nil && [selectedLiveAction integerValue] < liveFuncTitles.count) {
                    liveAction.detailTextLabel.text = [NSString stringWithFormat:@"%@", [liveFuncTitles objectAtIndex:[selectedLiveAction integerValue]]];
                } else {
                    liveAction.detailTextLabel.text = @"Lucid Settings";
                }
                liveAction.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
                liveAction.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return liveAction;
            }
            default:
                break;
        }
    } else if (indexPath.section == 6) {
        switch (indexPath.row) {
            case 0: {
                return [self createSwitchCellWithTitle:@"Velocidade Persistente"
                                                Detail:@"Mantém a velocidade de reprodução escolhida para todos os vídeos"
                                                   Key:@"playback_en"];
            }
            case 1: {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
                cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                cell.textLabel.text = @"Velocidade Selecionada";
                cell.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *selectedSpeed = [defaults valueForKey:@"playback_speed"];
                if (selectedSpeed != nil) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@x", selectedSpeed];
                } else {
                    cell.detailTextLabel.text = @"1.0x (Padrão)";
                }
                cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
        }
    } else if (indexPath.section == 7) {
        switch (indexPath.row) {
            case 0: {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
                cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                cell.textLabel.text = @"Lucid TikTok v1.0";
                cell.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                cell.detailTextLabel.text = @"Otimizado para iPhone 17 (OLED & Baixo Consumo na Rua)";
                cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
                cell.imageView.image = [UIImage systemImageNamed:@"sparkles"];
                cell.imageView.tintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                return cell;
            }
            case 1: {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
                cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                cell.textLabel.text = @"Economia de Bateria & Dados";
                cell.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                cell.detailTextLabel.text = @"Anúncios bloqueados e Live Streams suprimidas";
                cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
                cell.imageView.image = [UIImage systemImageNamed:@"battery.100.bolt"];
                cell.imageView.tintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                return cell;
            }
            case 2: {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
                cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
                cell.textLabel.text = @"Liquid Glass Monochrome";
                cell.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                cell.detailTextLabel.text = @"Design minimalista com destaque Off-White (#F5F5F7)";
                cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
                cell.imageView.image = [UIImage systemImageNamed:@"circle.lefthalf.filled"];
                cell.imageView.tintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
                return cell;
            }
            default:
                break;
        }
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 4 && indexPath.row == 1){
        CountryTable *countryTable = [[CountryTable alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:countryTable];
        [self presentViewController:navController animated:YES completion:nil];
    } else if (indexPath.section == 5 && indexPath.row == 1){
        LiveActions *liveActions = [[LiveActions alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:liveActions];
        [self presentViewController:navController animated:YES completion:nil];
    } else if (indexPath.section == 6 && indexPath.row == 1) {
        PlaybackSpeed *speedVC = [[PlaybackSpeed alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:speedVC];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

- (UITableViewCell *)createSwitchCellWithTitle:(NSString *)title Detail:(NSString*)detail Key:(NSString*)key {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.09 blue:0.10 alpha:1.0];
    
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.onTintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
    [cell.contentView addSubview:switchView];
    cell.accessoryView = switchView;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switchView.on = [defaults boolForKey:key];
    switchView.accessibilityLabel = key;
    [switchView addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.0];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = detail;
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.60 alpha:1.0];
    return cell;
}

- (void)switchToggled:(UISwitch *)sender {
    NSString *key = sender.accessibilityLabel;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.isOn forKey:key];
    [defaults synchronize];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:textField.text forKey:@"following_count"];
        [defaults synchronize];
    } else if (textField.tag == 2){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:textField.text forKey:@"follower_count"];
        [defaults synchronize];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
