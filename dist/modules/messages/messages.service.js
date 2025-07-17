"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessagesService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const message_entity_1 = require("./entities/message.entity");
const conversation_entity_1 = require("./entities/conversation.entity");
let MessagesService = class MessagesService {
    constructor(messagesRepository, conversationsRepository) {
        this.messagesRepository = messagesRepository;
        this.conversationsRepository = conversationsRepository;
    }
    async createConversation(customerId, driverId, bookingId) {
        let conversation = await this.conversationsRepository.findOne({
            where: { customerId, driverId, bookingId },
        });
        if (!conversation) {
            conversation = this.conversationsRepository.create({
                customerId,
                driverId,
                bookingId,
            });
            conversation = await this.conversationsRepository.save(conversation);
        }
        return conversation;
    }
    async sendMessage(createMessageDto) {
        const message = this.messagesRepository.create(createMessageDto);
        const savedMessage = await this.messagesRepository.save(message);
        await this.conversationsRepository.update({ id: createMessageDto.conversationId }, {
            lastMessage: createMessageDto.content,
            lastMessageAt: new Date(),
        });
        return savedMessage;
    }
    async getConversations(userId) {
        return this.conversationsRepository.find({
            where: [
                { customerId: userId },
                { driverId: userId },
            ],
            relations: ['customer', 'driver', 'booking'],
            order: { lastMessageAt: 'DESC' },
        });
    }
    async getMessages(conversationId) {
        return this.messagesRepository.find({
            where: { conversationId },
            relations: ['sender', 'recipient'],
            order: { createdAt: 'ASC' },
        });
    }
    async markMessagesAsRead(conversationId, userId) {
        await this.messagesRepository.update({
            conversationId,
            recipientId: userId,
            isRead: false,
        }, { isRead: true });
    }
    async getUnreadCount(userId) {
        return this.messagesRepository.count({
            where: {
                recipientId: userId,
                isRead: false,
            },
        });
    }
};
exports.MessagesService = MessagesService;
exports.MessagesService = MessagesService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(message_entity_1.Message)),
    __param(1, (0, typeorm_1.InjectRepository)(conversation_entity_1.Conversation)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository])
], MessagesService);
//# sourceMappingURL=messages.service.js.map