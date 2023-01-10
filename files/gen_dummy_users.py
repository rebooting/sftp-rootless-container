num=1001
max_users=20
max_users= num + max_users
f = open("users.conf", "w")
while num< (max_users):
    user_row = "{0}:123:{0}:100:upload".format(str(num))
    f.write(user_row+"\n")
    num = num +1
f.close()

num=1001
f = open("socket.txt", "w")
while num< (max_users):
    user_row = 'input(type="imuxsock" Socket="/home/{0}/dev/log" CreatePath="on")'.format(str(num))
    f.write(user_row+"\n")
    num = num +1
f.close()
