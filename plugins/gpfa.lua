local function chat_list(msg)
    local data = load_data(_config.moderation.data)
        local groups = 'groups'
        if not data[tostring(groups)] then
                return 'No groups at the moment'
        end
        local message = 'List of your bot Groups:\n\n '
        for k,v in pairs(data[tostring(groups)]) do
                local settings = data[tostring(v)]['settings']
                for m,n in pairsByKeys(settings) do
                        if m == 'set_name' then
                                name = n
                        end
                end

                message = message .. 'ًں‘¥ '.. name .. ' (ID: ' .. v .. ')\n\n '
        end
        local file = io.open("./groups/lists/listed_groups.txt", "w")
        file:write(message)
        file:flush()
        file:close()
        return message
end
local function run(msg, matches)
  if msg.to.type ~= 'chat' or is_sudo(msg) and is_realm(msg) then
  local data = load_data(_config.moderation.data)
  if is_sudo(msg) then
    if matches[1] == 'لینک' and data[tostring(matches[2])] then
        if is_banned(msg.from.id, matches[2]) then
     return '⛔️ شما بن هستید !'
  end
      if is_gbanned(msg.from.id) then
            return '🚫 شما سوپربن هستید !'
      end
      if data[tostring(matches[2])]['settings']['lock_member'] == 'yes' and not is_owner2(msg.from.id, matches[2]) then
        return '🚫گروه عمومی نیست !'
      end
          local chat_id = "chat#id"..matches[2]
          local user_id = "user#id"..msg.from.id
      chat_add_user(chat_id, user_id, ok_cb, false)   
   local group_link = data[tostring(matches[2])]['settings']['set_link']
   return "💈لینک گروه مورد نظر :\n"..group_link.."\n\n⚙ آیدی گروه : "..matches[2].."\n💈 از چنل ما بازدید کنید!\n > @MegaTesla_Ch \n 👕  طراح و توسعه دهندھ : \n > @The_DeSigN3r"
    elseif matches[1] == 'لینک' and not data[tostring(matches[2])] then

          return "❌ گروه پیدا نشد!"
         end
    end
  else
   return "⚠️ فقط برای سازنده بات!"
  end

     if matches[1] == 'لیست گروه ها' then
      if is_sudo(msg) and msg.to.type == 'chat' then
         return chat_list(msg)
       elseif msg.to.type ~= 'chat' then
         return chat_list(msg)
      end
 end
 end
return {
    description = "See link of a group and groups list",
    usage = "!link ID && !groups",
patterns = {
"^(لینک) (.*)$",
"^(لیست گروه ها)$",
},
run = run
}

--Powered By : @The_DeSigN3r