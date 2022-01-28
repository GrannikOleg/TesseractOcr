#!/bin/bash
 E='echo -e';e='echo -en';trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
# 25 возможно это
 CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[45m";}
# 0 это цвет заднего фона списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~
 R(){ CLEAR ;stty sane;CLEAR;};
#R(){ CLEAR ;stty sane;$e "\ec\e[37;44m\e[J";};
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 HEAD(){ for (( a=2; a<=33; a++ ))
 do
 TPUT $a 1
        $E "\xE2\x94\x82                                                                              \xE2\x94\x82";
 done
 TPUT 3 4
        $E "\033[1;32m *** Tesseract-ocr ***\033[0m";
 TPUT 5 4
        $E "\033[2mДвигатель OCR в командной строке. Извлечение текста из цифровых изображений\033[0m";
 TPUT 6 1
        $E "\033[2m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";
 TPUT 16 4
        $E "\033[36mВход/Выход Аргументы      \033[0m IN/OUT ARGUMENTS\033[0m";
 TPUT 19 4
        $E "\033[36mЯзыки и скрипты           \033[0m LANGUAGES AND SCRIPTS\033[0m";
 TPUT 25 4
        $E "\033[36mENVIRONMENT VARIABLES     \033[0m ПЕРЕМЕННЫЕ ОКРУЖАЮЩЕЙ СРЕДЫ";
 TPUT 30 3
        $E "$(tput setaf 2)  Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter$(tput sgr 0) ";
 MARK;TPUT 1 1
        $E "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+";UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 34 1
        $E "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
  M0(){ TPUT  7 3; $e "  Руководство пользователя\033[32m man                                             \033[0m";}
  M1(){ TPUT  8 3; $e "  Установка               \033[32m install                                         \033[0m";}
  M2(){ TPUT  9 3; $e "  Обзор                   \033[32m Synopsis                                        \033[0m";}
  M3(){ TPUT 10 3; $e "  Описание                \033[32m Description                                     \033[0m";}
  M4(){ TPUT 11 3; $e "  История                 \033[32m History                                         \033[0m";}
  M5(){ TPUT 12 3; $e "  Ресурсы                 \033[32m Resources                                       \033[0m";}
  M6(){ TPUT 13 3; $e "  Aвторы                  \033[32m Authors                                         \033[0m";}
  M7(){ TPUT 14 3; $e "  Копирование             \033[32m Copying                                         \033[0m";}
  M8(){ TPUT 15 3; $e "  Смотрите также          \033[32m See Also                                        \033[0m";}
#
  M9(){ TPUT 17 3; $e "  Файл                    \033[32m FILE                                            \033[0m";}
 M10(){ TPUT 18 3; $e "  Выходная база           \033[32m OUTPUTBASE                                      \033[0m";}
#
 M11(){ TPUT 20 3; $e "  Языки                                                                    ";}
 M12(){ TPUT 21 3; $e "  Сценарии                                                                 ";}
 M13(){ TPUT 22 3; $e "  Извлечение                                                               ";}
 M14(){ TPUT 23 3; $e " Конфигурационный вайл                                                     ";}
 M15(){ TPUT 24 3; $e " Настройка файлов и дополнение данными пользователя                        ";}
#
 M16(){ TPUT 26 3; $e "                           \033[32mTESSDATA_PREFIX                                  \033[0m";}
 M17(){ TPUT 27 3; $e "                           \033[32mOMP_THREAD_LIMIT                                 \033[0m";}
 M18(){ TPUT 28 3; $e " \033[1;36mОпции                      \033[90mOptions                                        \033[0m";}
 M19(){ TPUT 29 3; $e " Перечитать файлы циклом   \033[32mfor                                             \033[0m";}
#
 M20(){ TPUT 31 3; $e " \033[36mGrannik Git --------------------------------------------------------------\033[0m";}
 M21(){ TPUT 32 3; $e " EXIT                                                                      ";}
LM=21
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC;if [[ $cur == enter ]];then R;echo " man tesseract";ES;fi;;
  1) S=M1;SC;if [[ $cur == enter ]];then R;echo "
 sudo apt-get install tesseract-ocr
 sudo apt-get install tesseract-ocr-cym
#
 Инсталляционный пакет называется «tesseract-ocr-» с сокращением языка, помеченным на конце.
 Чтобы установить файл с валлийским языком в Ubuntu, мы будем использовать:
 sudo apt-get install tesseract-ocr-cym
";ES;fi;;
  2) S=M2;SC;if [[ $cur == enter ]];then R;echo " tesseract FILE OUTPUTBASE [OPTIONS]... [CONFIGFILE]...";ES;fi;;
  3) S=M3;SC;if [[ $cur == enter ]];then R;echo "   Это механизм оптического распознавания символов OCR (Optical Character Recognition) tesseract - движок из командной строки OCR коммерческого качества, первоначально
 разработанный в HP в период с 1985 по 1995 год. Его исходный код был открыт HP и UNLV в 2005 году, и с тех пор он разрабатывается в Google.";ES;fi;;
  4) S=M4;SC;if [[ $cur == enter ]];then R;echo "   Двигатель был разработан в Hewlett Packard Laboratories Bristol и Hewlett Packard Co, Грили Колорадо в период с 1985 по 1994 год, с некоторыми другими изменениями.
 Сделано в 1996 году для переноса на Windows, а некоторые - на C ++ в 1998 году. Большая часть кода была написана на C, а затем еще часть была написана на C ++. Код
 C ++ делает интенсивное использование системы списков с использованием макросов. Это предшествовало STL, было переносимым до STL и более эффективно, чем списки STL,
 но имеет большой минус: если вы действительно получаете нарушение сегментации, это сложно отлаживать. Версия 2.00 принесла поддержку Unicode (UTF-8), шесть языков и
 возможность обучать Tesseract. Tesseract был включен в четвертый ежегодный тест UNLV на точность распознавания текста:
 https://github.com/tesseract-ocr/docs/blob/master/AT-1995.pdf
 Поскольку Тессеракт 2.00, теперь включены скрипты, позволяющие любому воспроизвести некоторые из этих тестов:
 https://github.com/tesseract-ocr/tesseract/wiki/TestingTesseract
   Tesseract 3.00 добавлен ряд новых языков, включая китайский, японский и корейский. Также была представлена новая однофайловая система управления языковые данные.
   Tesseract 3.02 добавлена поддержка двунаправленного текста, возможность распознавания нескольких языков в одном изображении и улучшенный анализ макета.
   Tesseract 4 добавляет новый механизм OCR на основе нейронной сети (LSTM), который ориентирован на распознавание строк, но также по-прежнему поддерживает устаревший
 механизм OCR Tesseract.
   Tesseract 3, который работает, распознавая шаблоны символов. Совместимость с Tesseract 3 обеспечивается параметром --oem 0 Для этого также требуются файлы
 обученных данных, которые поддерживать устаревший движок, например, из репозитория tessdata:
   https://github.com/tesseract-ocr/tessdata
   Дополнительные сведения см. В примечаниях к выпуску в вики-странице Tesseract:
   https://github.com/tesseract-ocr/tesseract/wiki/ReleaseNotes";ES;fi;;
  5) S=M5;SC;if [[ $cur == enter ]];then R;echo " Main web site:           https://github.com/tesseract-ocr
 User forum:              http://groups.google.com/group/tesseract-ocr
 Wiki:                    https://github.com/tesseract-ocr/tesseract/wiki
 Information on training: https://github.com/tesseract-ocr/tesseract/wiki/TrainingTesseract";ES;fi;;
  6) S=M6;SC;if [[ $cur == enter ]];then R;echo "   Разработкой Tesseract руководил Рэй Смит в компаниях Hewlett-Packard и Google. В команду разработчиков вошли: Ахмад Абдулкадер,
 Крис Ньютон, Дэн Джонсон, Дар-Шьянг Ли, Дэвид Эгер, Эрик Вайсблатт, Фейсал Шафаит, Хироши Такенака, Джо Лю, Джорн Ванке, Марк Матрос,
 Микки Намики, Николас Беато, Одед Фурманн, Фил Читл, Пингпинг Сю, Понг Эксомбатчай (Чантат), Ранджит Унникришнан, Ракель Романо,
 Рэй Смит, Рика Антонова, Роберт Мосс, Сэмюэл Чаррон, Шила Ллойд, Шобхит Саксена и Томас Килбус.
 Список участников см: https://github.com/tesseract-ocr/tesseract/blob/master/AUTHORS";ES;fi;;
  7) S=M7;SC;if [[ $cur == enter ]];then R;echo " Лицензия Apache License, Версия 2.0";ES;fi;;
  8) S=M8;SC;if [[ $cur == enter ]];then R;echo " ambiguous_words, cntraining, combine_tessdata, dawg2wordlist, shape_training, mftraining, unicharambigs, unicharset, unicharset_extractor, wordlist2dawg";ES;fi;;
  9) S=M9;SC;if [[ $cur == enter ]];then R;echo "
 Имя входного файла. Это может быть файл изображения или текстовый файл. Поддерживаются большинство форматов файлов изображений (все,
 что может читать Leptonica). В текстовом файле перечислены имена всех входных изображений (по одному имени в строке). Результаты
 будут объединены в один файл для каждого формата выходного файла. (txt, pdf, hocr, xml).
 Если ФАЙЛ является стандартным вводом или - тогда используется стандартный ввод.
";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo "
 Базовое имя выходного файла (к которому будет добавлено соответствующее расширение). По умолчанию выводом будет текстовый
 файл с .txt, добавленным в basename, если не установлен один или несколько параметров, явно указывающих желаемый результат.
 Если OUTPUTBASE - стандартный вывод или -, то используется стандартный вывод.
";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo "
 afr (африкаанс)
 amh (амхарский) ara (арабский)
 asm (ассамский)
 aze (азербайджанский) aze_cyrl (азербайджанский - кириллица)
 bel (белорусский)
 ben (бенгальский)
 bod (Тибетский)
 bos (боснийский)
 bre (бретонский)
 bul (болгарский)
 cat (каталонский; валенсийский)
 ceb (кебуанский)
 ces (чешский)
 chi_sim (китайский упрощенный)
 chi_tra (Традиционный китайский)
 chr (чероки)
 cym (валлийский)
 dan (датский)
 deu (немецкий)
 dzo (дзонгха)
 ell (греческий, современный, 1453-)
 eng (английский)
 enm (английский, Middle, 1100-1500)
 epo (эсперанто)
 equ (модуль определения математики / уравнений)
 est (эстонский)
 eus (баскский)
 fas (персидский)
 fin (финский)
 fra (французский)
 frk (Франкский)
 frm (французский, средний, ок. 1400-1600),
 gle (ирландский)
 glg (галисийский)
 grc (греческий, древний, до 1453 г.)
 guj (гуджарати), hat (гаитянский; гаитянский креольский)
 heb (иврит)
 hin (хинди)
 hrv (хорватский)
 hun (венгерский)
 iku (инуктитут)
 ind (индонезийский)
 isl (исландский)
 ita (итальянский)
 ita_old (итальянский - старый)
 jav (Яванский)
 jpn (японский)
 kan (каннада)
 kat (грузинский) kat_old (грузинский - древний)
 kaz (казахский)
 khm (центральный кхмерский)
 kir (киргизский; киргизский)
 kmr (курдский Kurmanji)
 kor (корейский), kor_vert (корейский вертикаль)
 kur (курдский)
 lao (лаосский)
 lat (латинский)
 lav (латышский)
 lit (литовский)
 ltz (люксембургский)
 mal (Малаялам)
 mar (маратхи)
 mkd (македонский)
 mlt (мальтийский)
 mon (монгольский)
 mri (маори)
 msa (малайский)
 mya (бирманский)
 nep (непальский)
 nld (голландский; фламандский)
 nor (норвежский)
 oci (окситанский пост 1500)
 ori (ория)
 osd (модуль определения ориентации и сценария)
 pan (панджаби; пенджаби)
 pol (польский)
 por (Португальский)
 pus (пушту; пушту)
 que (кечуа)
 ron (румынский; молдавский; молдавский)
 rus (русский)
 san (санскрит)
 sin (сингальский; сингальск)
 slk (Словацкий)
 slv (словенский)
 snd (синдхи)
 spa (испанский; кастильский), spa_old (испанский; кастильский - старый)
 sqi (албанский)
 srp (сербский), srp_latn (сербский - Латинский)
 sun (сунданский)
 swa (суахили)
 swe (шведский)
 syr (сирийский)
 tam (тамильский)
 tat (татарский)
 tel (телугу)
 tgk (таджикский)
 tgl (тагальский)
 tha ( Тайский) тир (Тигринья)
 ton (тонга)
 tur (турецкий)
 uig (уйгурский; уйгурский)
 ukr (украинский)
 urd (урду)
 uzb (узбекский), uzb_cyrl (узбекский - кириллица)
 vie (вьетнамский)
 yid (Идиш)
 йор (йоруба)
";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo "
    Чтобы распознать какой-либо текст с помощью Tesseract, обычно необходимо указать язык (и) или сценарий (и) текста (если только это не английский текст,
 поддерживается по умолчанию) с использованием -l LANG или -l SCRIPT. При автоматическом выборе языка также выбираются языковой набор символов и словарь (список слов).
    При выборе сценария обычно выбираются все символы этого сценария, которые могут быть на разных языках. Включенный словарь также содержит микс с разных языков.
 В большинстве случаев скрипт также поддерживает английский язык. Таким образом, можно распознать язык, который специально не обучены с использованием обученных
 данных для сценария, на котором они написаны. С помощью + можно указать несколько языков или сценариев. https://github.com/tesseract-ocr/tessdata_fast
 предоставляет быстрые модели языков и сценариев, которые также являются частью дистрибутивов Linux.
    Чтобы использовать нестандартный языковой пакет с именем foo.traineddata, установите переменную среды TESSDATA_PREFIX, чтобы файл можно было найти по адресу
 TESSDATA_PREFIX /tessdata/foo.traineddata и передайте Tesseract аргумент -l foo. Для Tesseract 4 tessdata_fast включает файлы обученных данных для следующих скриптов:
 Арабский, армянский, бенгальский, канадские аборигены, чероки, кириллица, деванагари, эфиопский язык, фрактур, грузинский, греческий, гуджарати, гурмукхи, ханс
 (хан упрощенный), HanS_vert (ханьский упрощенный, вертикальный), HanT (традиционный ханьский), HanT_vert (традиционный ханьский, вертикальный), хангыль,
 Hangul_vert (хангыль вертикальный), Иврит, японский, Japanese_vert (японская вертикаль), каннада, кхмерский, лаосский, латынь, малаялам, Мьянма, ория (одия),
 сингальский, сирийский, тамильский, телугу, тхана, Тайский, тибетский, вьетнамский.
    Те же языки и скрипты доступны на https://github.com/tesseract-ocr/tessdata_best. tessdata_best предоставляет медленные модели языка и сценариев. Эти модели
 нужны для обучения. Они также могут дать лучшие результаты OCR, но распознавание занимает гораздо больше времени. И tessdata_fast, и tessdata_best поддерживают
 только механизм LSTM OCR.
    Существует третий репозиторий, https://github.com/tesseract-ocr/tessdata, с моделями, которые поддерживают как устаревший механизм распознавания текста
 Tesseract 3, так и Tesseract. 4 LSTM OCR Engine.
";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo " Пример: tesseract myimage.png myimage -l eng + deu + fra";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo "
 Имя используемой конфигурации. Имя может быть файлом в tessdata/configs или tessdata/tessconfigs, либо абсолютным или относительным
 путем к файлу. Конфиг - это текстовый файл, содержащий список параметров и их значений, по одному в каждой строке, с пробелом,
 отделяющим параметр от значения. Интересные файлы конфигурации включают:
  alto - вывод в формате ALTO (OUTPUTBASE.xml).
  hocr - вывод в формате hOCR (OUTPUTBASE.hocr).
  pdf - выходной PDF (OUTPUTBASE.pdf).
  tsv - Выходной TSV (OUTPUTBASE.tsv).
  txt - выводить обычный текст (OUTPUTBASE.txt).
  get.images - записывать обработанные входные изображения в файл (tessinput.tif).
  logfile - перенаправлять отладочные сообщения в файл (tesseract.log).
  lstm.train - выходные файлы, используемые при обучении LSTM (OUTPUTBASE.lstmf).
  makebox - Запись файлового ящика (OUTPUTBASE.box).
  quiet - перенаправлять отладочные сообщения в /dev/null.
 Можно выбрать несколько файлов конфигурации, например, tesseract image.png demo alto hocr pdf txt создаст четыре выходных файла
 demo.alto, demo.hocr, demo.pdf и demo.txt с результатами распознавания текста.
 Примечание: параметры -l LANG, -l SCRIPT и --psm N должны указываться перед любым CONFIGFILE. 
";ES;fi;;
 15) S=M15;SC;if [[ $cur == enter ]];then R;echo "
 Файлы конфигурации Tesseract состоят из строк с парами параметров и значений (разделенных пробелами). Параметры задокументированы как
 флаги в исходном коде, например следующий в tesseractclass.h:
  STRING_VAR_H (tessedit_char_blacklist, \"\", \"Черный список символов, которые нельзя распознать\");
 Эти параметры могут включать или отключать различные функции движка и могут заставлять его загружать (или не загружать) различные
 данные. Например, предположим, что вы хотите OCR на английском языке, но подавите обычный словарь и загрузите альтернативный список
 слов и альтернативный список шаблонов - эти два файла являются наиболее часто используемые файлы дополнительных данных.
 Если ваш языковой пакет находится в /path/to/eng.traineddata, а конфигурация hocr находится в /path/to/configs/hocr,
 создайте три новых файла:
       /path/to/eng.user-words:
           the
           quick
           brown
           fox
           jumped
       /path/to/eng.user-patterns:
           1-\d\d\d-GOOG-411
           www.\n\\\*.com
       /path/to/configs/bazaar:
           load_system_dawg     F
           load_freq_dawg       F
           user_words_suffix    user-words
           user_patterns_suffix user-patterns
 Теперь, если вы передадите слово bazaar как CONFIGFILE в Tesseract, Tesseract не будет загружать ни системный словарь, ни словарь
 часто встречающихся слов. и будет загружать и использовать предоставленные вами файлы eng.user-words и eng.user-patterns.
 Первый - это простой список слов, по одному в каждой строке. Формат последнего задокументирован в dict/trie.h в read_pattern_list().
";ES;fi;;
 16) S=M16;SC;if [[ $cur == enter ]];then R;echo "
 Если для TESSDATA_PREFIX задан путь, то этот путь используется для поиска каталога tessdata с моделями распознавания языка и сценария
 и конфигурацией файлы. Рекомендуемой альтернативой является использование --tessdata-dir PATH.
";ES;fi;;
 17) S=M17;SC;if [[ $cur == enter ]];then R;echo "
 Если исполняемый файл tesseract был построен с поддержкой многопоточности, он обычно будет использовать четыре ядра ЦП для процесса
 OCR. Хотя это может быть быстрее для одного изображения это дает плохую производительность, если на главном компьютере меньше четырех
 ядер ЦП или если OCR выполняется для многих изображений. Только один Ядро ЦП используется с OMP_THREAD_LIMIT = 1.
";ES;fi;;
 18) S=M18;SC;if [[ $cur == enter ]];then R;./mtesseractOptions.sh;ES;fi;;
 19) S=M19;SC;if [[ $cur == enter ]];then R;echo "
 for i in turing*.jpeg; do tesseract \"\$i\" \"text-\$i\" -l eng; done;
";ES;fi;;
#
 20) S=M20;SC;if [[ $cur == enter ]];then R;echo "
 Grannik Git | 2022/01/28
";ES;fi;;
 21) S=M21;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done