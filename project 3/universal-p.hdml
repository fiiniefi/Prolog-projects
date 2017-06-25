#include <gtk/gtk.h>
#include <stdlib.h>
#include <stdbool.h>
#include "interface.h"


extern int exists[64];
extern int seconds;


void draw_map (prysowanie data)
{
    gtk_window_resize(GTK_WINDOW(okno), 1920, 1080);
    gtk_widget_destroy(siatka_na_przyciski);
    siatka_na_przyciski=gtk_grid_new();
    gtk_grid_set_column_homogeneous(GTK_GRID(siatka_na_przyciski), TRUE);
    gtk_grid_set_row_homogeneous(GTK_GRID(siatka_na_przyciski), TRUE);
    gtk_grid_set_row_spacing(GTK_GRID(siatka_na_przyciski), 2);
    gtk_grid_set_column_spacing(GTK_GRID(siatka_na_przyciski), 2);
    gtk_container_set_border_width(GTK_CONTAINER(siatka_na_przyciski), 10);
    GtkWidget *labeltop=gtk_label_new("");
    GtkWidget *labelbottom=gtk_label_new("");

    /*interface_grid=gtk_grid_new();
    gtk_widget_set_name(GTK_WIDGET(interface_grid), "counts");
    gtk_grid_set_column_homogeneous(GTK_GRID(interface_grid), TRUE);
    gtk_grid_set_row_homogeneous(GTK_GRID(interface_grid), TRUE);
    gtk_container_set_border_width(GTK_CONTAINER(interface_grid), 10);*/

    gtk_grid_attach(GTK_GRID(siatka_na_przyciski), labeltop, 0, 0, ((data->n+1)*3)+data->n, 1);
    int i;
    for (i=0; i<data->n; i++)
    {
        for (int p=0; p<data->n; p++)
        {
            if (data[(i*data->n)+p].kafelek == NULL)
                continue;
            else
            {
                gtk_grid_attach(GTK_GRID(siatka_na_przyciski), data[(i*data->n)+p].kafelek, (p*2)+1, (i*5)+1, 2, 5);
                gtk_button_set_image(GTK_BUTTON(data[(i*data->n)+p].kafelek), data[(i*data->n)+p].rewers);
            }
        }
    }
    gtk_grid_attach(GTK_GRID(siatka_na_przyciski), labelbottom, 0, ((i*5)+1), ((data->n+1)*3)+data->n, 1);
    //gtk_grid_attach(GTK_GRID(siatka_na_przyciski), interface_grid, (data->n*2)+6, 0, (data->n)+data->n/2, (data->n*5)+2);
    if (data->tryb_gry == 0)
        interface_map_sixteen(data);

    else if (data->tryb_gry == 1)
        interface_map_thirtysix(data);

    else if (data->tryb_gry == 2)
        interface_map_sixtyfour(data);

    else if (data->tryb_gry == 3)
        interface_map_multi(data);

    else
        exit(0);
    /*GtkWidget *labelfirst=gtk_label_new("");
    GtkWidget *first_player;
    GtkWidget *second_player;
    GtkWidget *scores;
    first_player=gtk_label_new(data->pierwszy_gracz);
    second_player=gtk_label_new(data->drugi_gracz);
    actualize_scores(data);
    scores=gtk_label_new("Wyniki:");
    gtk_widget_set_name(scores, "label");
    gtk_widget_set_name(first_player, "names");
    gtk_widget_set_name(second_player, "names");
    gtk_grid_attach(GTK_GRID(interface_grid), labelfirst, 0, 0, 10, 1);
    gtk_grid_attach(GTK_GRID(interface_grid), scores, 0, 3, 5, 4);
    gtk_grid_attach(GTK_GRID(interface_grid), first_player, 0, 6, 10, 4);
    gtk_grid_attach(GTK_GRID(interface_grid), second_player, 0, 13, 10, 4);
    GtkWidget *now;
    now=gtk_label_new("Ruch gracza:");
    gtk_widget_set_name(now, "names");
    gtk_grid_attach(GTK_GRID(interface_grid), now, 0, 30, 4, 10);
    whos_turn_now(data);*/
    gtk_container_add(GTK_CONTAINER(okno), siatka_na_przyciski);


    /*g_timeout_add(20000, (GSourceFunc)(glowne_menu), NULL);
    g_timeout_add_seconds(1, (GSourceFunc)wywolaj, NULL);*/
    if (data->tryb_gry != 3)
    {
        data->control_timer=g_timeout_add((data->sekundy-seconds+1)*1000, (GSourceFunc)(lose_screen), data);
        g_timeout_add_seconds(1, (GSourceFunc)actualize_seconds, data);
    }

    gtk_widget_show_all(okno);
}



void create_game_buttons(prysowanie data)  //tworzy przyciski i laczy z funkcja
{
    for (int i=0; i<(data[0].n)*(data[0].n); i++)
    {
        data[i].kafelek=gtk_button_new();
        gtk_widget_set_name(GTK_WIDGET(data[i].kafelek), "game_button");
        if (data[0].tryb_gry == 3)
            g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(multi_invert), &data[i]);
        else if (data[0].tryb_gry == 2)
            g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(single_invert), &data[i]);
        else if (data[0].tryb_gry == 1)
            g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(single_invert), &data[i]);
        else if (data[0].tryb_gry == 0)
            g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(single_invert), &data[i]);
        else
            exit(0);
    }
}



void set_skins(prysowanie data)  //wypelnia tablice skinow i adresow do skinow
{
    for (int i=0; i<(data[0].n)*(data[0].n); i++)
    {
        if (data[0].n == 8)
        {
            data[i].rewers_adres="data/txt/img/kafelki/p64/background.jpg";
            data[i].rewers=gtk_image_new_from_file(data[i].rewers_adres);
        }
        else if (data[0].n == 6)
        {
            data[i].rewers_adres="data/txt/img/kafelki/p36/background.jpg";
            data[i].rewers=gtk_image_new_from_file(data[i].rewers_adres);
        }
        else if (data[0].n == 4)
        {
            data[i].rewers_adres="data/txt/img/kafelki/p16/background.jpg";
            data[i].rewers=gtk_image_new_from_file(data[i].rewers_adres);
        }
    }
}


void set_position_and_n(prysowanie data)
{
    for (int i=0; i<(data[0].n)*(data[0].n); i++)
    {
        data[i].pozycja=i;
        data[i].n=data[0].n;
        data[i].sekundy=data[0].sekundy;
        data[i].istnieje_licznik=1;
        for (int j=0; j<16; j++)
        {
            data[i].pierwszy_gracz[j]=data[0].pierwszy_gracz[j];
            if (data[0].pierwszy_gracz[j] == '\0')
                break;
        }

        for (int j=0; j<16; j++)
        {
            data[i].drugi_gracz[j]=data[0].drugi_gracz[j];
            if (data[0].drugi_gracz[j] == '\0')
                break;
        }
        data[i].tryb_gry=data[0].tryb_gry;
    }
}


void null_pictures(prysowanie data)
{
    for (int i=0; i<(data[0].n)*(data[0].n); i++)
    {
        data[i].awers=NULL;
    }
}


void set_pictures(prysowanie data)   //wypelnia tablice obrazkow kafelkow i ich adresow
{
    int occupied=0;
    int drawn=0;
    int drawn_button=0;
    bool used[92]={0};
    srand(time(NULL));

    for (int i=0; i<(data[0].n)*(data[0].n); i++)
    {
        if (data[i].awers != NULL)
            continue;

        do
        {
            drawn=rand()%92;
        } while (used[drawn] == 1);

        used[drawn]=1;
        occupied++;
        data[i].awers=gtk_image_new();
        data[i].numer_obrazka=drawn;

        if (data[0].n == 4)
        {
            data[i].awers_adres=najwieksze[drawn];
            data[i].awers=gtk_image_new_from_file(najwieksze[drawn]);
        }

        else if (data[0].n == 6)
        {
            data[i].awers_adres=srednie[drawn];
            data[i].awers=gtk_image_new_from_file(srednie[drawn]);
        }

        else if (data[0].n == 8)
        {
            data[i].awers_adres=najmniejsze[drawn];
            data[i].awers=gtk_image_new_from_file(najmniejsze[drawn]);
        }
        else
            exit(0);

        if (( (data[0].n)*(data[0].n) - occupied ) == 0)
            exit(0);

        drawn_button=rand()% ( ( (data[0].n) * (data[0].n) ) - occupied );

        int j=i;
        while ( j < (data[0].n)*(data[0].n) && drawn_button > -1 )
        {
            if (data[j].awers == NULL)
            {
                if (drawn_button == 0)
                {
                    data[j].awers=gtk_image_new();
                    data[j].numer_obrazka=drawn;

                    if (data[0].n == 4)
                    {
                        data[j].awers_adres=najwieksze[drawn];
                        data[j].awers=gtk_image_new_from_file(najwieksze[drawn]);
                    }

                    else if (data[0].n == 6)
                    {
                        data[j].awers_adres=srednie[drawn];
                        data[j].awers=gtk_image_new_from_file(srednie[drawn]);
                    }

                    else if (data[0].n == 8)
                    {
                        data[j].awers_adres=najmniejsze[drawn];
                        data[j].awers=gtk_image_new_from_file(najmniejsze[drawn]);
                    }
                    else
                        exit(0);
                    drawn_button--;
                }

                else
                    drawn_button--;
            }

            j++;
        }//while

        occupied++;

    }
}



GtkWidget *main_menu_button()
{
    GtkWidget *button;
    button=gtk_button_new_with_label("Główne menu");
    gtk_widget_set_name(button, "main_menu_button");
    g_signal_connect(G_OBJECT(button), "clicked", G_CALLBACK(glowne_menu), NULL);
    return button;
}



void set_pictures_load(prysowanie data)
{
    for (int i=0; i<(data->n*data->n); i++)
    {
        data[i].awers=gtk_image_new();
        if (data[i].n == 4)
        {
            data[i].awers_adres=najwieksze[data[i].numer_obrazka];
            data[i].awers=gtk_image_new_from_file(data[i].awers_adres);
        }

        else if (data[i].n == 6)
        {
            data[i].awers_adres=srednie[data[i].numer_obrazka];
            data[i].awers=gtk_image_new_from_file(data[i].awers_adres);
        }

        else if (data[i].n == 8)
        {
            data[i].awers_adres=najmniejsze[data[i].numer_obrazka];
            data[i].awers=gtk_image_new_from_file(data[i].awers_adres);
        }

        else
            exit(0);
    }
}




void create_game_buttons_load(prysowanie data)
{
    for (int i=0; i<(data[0].n)*(data[0].n); i++)
    {
        if (exists[i] == 0)
            data[i].kafelek=NULL;
        else
        {
            data[i].kafelek=gtk_button_new();
            gtk_widget_set_name(GTK_WIDGET(data[i].kafelek), "game_button");
            if (data[0].tryb_gry == 3)
                g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(multi_invert), &data[i]);
            else if (data[0].tryb_gry == 2)
                g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(single_invert), &data[i]);
            else if (data[0].tryb_gry == 1)
                g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(single_invert), &data[i]);
            else if (data[0].tryb_gry == 0)
                g_signal_connect(G_OBJECT(data[i].kafelek), "clicked", G_CALLBACK(single_invert), &data[i]);
            else
                exit(0);
        }
    }
}
