
ActionCable.server.config.log_tags = [
  -> request { request.env['bc.account_id'] || 'no-account' },
  :action_cable,
  -> request { request.uuid }
]

