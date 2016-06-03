antiaudio= {}-- An empty table for solving multiple kicking problem

do
local function run(msg, matches)
  if is_momod(msg) then -- Ignore mods,owner,admins
    return
  end
  local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)]['settings']['lock_audio'] then
    if data[tostring(msg.to.id)]['settings']['lock_audio'] == 'yes' then
	  if is_whitelisted(msg.from.id) then
		return
	  end
      if antiaudio[msg.from.id] == true then 
        return
      end
	  if msg.to.type == 'channel' then
		local receiver = get_receiver(msg)
		local username = msg.from.username
		local name = msg.from.first_name
		if username and is_super_group(msg) then
			send_large_msg(receiver , "🔺 اسم : "..name.."\n🆔 آیدی : "..msg.from.id.."\n🔻 یوزرنیم : @"..msg.from.username.."\n🔒 فرستادن صدا ممنوع است!\n⚠️ #وضعیت : فرد اخراج شد!")
		else
			send_large_msg(receiver , "🔺 اسم : "..name.."\n🆔 آیدی : "..msg.from.id.."\n🔒 فرستادن صدا ممنوع است!\n⚠️ #وضعیت : فرد اخراج شد!")
		end
		local name = user_print_name(msg.from)
		savelog(msg.to.id, name.." ["..msg.from.id.."] kicked (audio was locked) ")
		local channel_id = msg.to.id
		local user_id = msg.from.id
		  delete_msg(msg.id,ok_cb,false) 
		  kick_user(user_id, channel_id)
		end
		antiaudio[msg.from.id] = true
    end
  end
  return
end

local function cron()
  antiaudio = {} -- Clear antifosh table 
end

return {
  patterns = {
"%[(audio)%]",
"%[(document)%]",
    },
  run = run,
  cron = cron
}

end
--
