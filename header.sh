def_name(){
    len=${#name}
    max=$((80 - $len - 29))
    for (( c=1; c<=max; c++ ))
    do
        name+=" "
    done
}

date=$(date "+%Y/%m/%d %H:%M:%S")
echo -e "$header"
if [ $1 == "-d" ]; then
    param=( $( find $2 -name "*.c" ) $( find $2 -name "*.h" ) )
else
    param=$@
fi

for file in "${param[@]}"
do
    name=$( basename $file)
    def_name
    header="/* ************************************************************************** */\n"
    header+="/*                                                                            */\n"
    header+="/*                                                        :::      ::::::::   */\n"
    header+="/*   $name:+:      :+:    :+:   */\n"
    header+="/*                                                    +:+ +:+         +:+     */\n"
    header+="/*   By: yalthaus <marvin@42lausanne.ch>            +#+  +:+       +#+        */\n"
    header+="/*                                                +#+#+#+#+#+   +#+           */\n"
    header+="/*   Created: $date by yalthaus          #+#    #+#             */\n"
    header+="/*   Updated: $date by yalthaus         ###   ########.fr       */\n"
    header+="/*                                                                            */\n"
    header+="/******************************************************************************/\n"
    if [[ $(head -c 80 $file) != "${header::80}" ]]; then
        echo -e "$(echo -e "$header" | cat - $file)" > $file
        echo "header add in $file"
    else
        echo "header already was in $file"
    fi
done