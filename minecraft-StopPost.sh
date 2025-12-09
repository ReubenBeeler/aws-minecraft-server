rm -f $MC_FIFO

if [[ -d $EBS/minecraft ]]; then
    zip backup.zip -r $EBS/minecraft  # auto removes previous backup.zip if exists
fi

cp -r $MC_PATH $EBS/minecraft